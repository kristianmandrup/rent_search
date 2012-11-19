class Property::Search::Criteria::Mapper
  class Base
    include Property::Search::Preferences::Validator

    attr_reader :criteria_hash, :preferences

    def initialize criteria_hash, preferences = nil
      @criteria_hash = Hashie::Mash.new criteria_hash

      unless valid_preferences? preferences
        raise ArgumentError, "Must be a Property::Criteria::Preferences, was: preferences"
      end

      # create default preferences if none provided
      @preferences = preferences || preferences_clazz.new
    end

    def mapped_hash
      normalized_criteria.inject({}) do |res, (key, value)|
        mapped = map(key, value)
        res.merge!(mapped) if mapped
        res
      end
    end

    protected

    def preferences_clazz
      Property::Search::Preferences
    end

    delegate :currency, :area_unit, to: :preferences

    def map key, value
      key = map_key(key)
      mapped =  map_value(key, value)
      return nil if !mapped
      {key.to_sym => mapped}
    end

    # TODO: Currency mapping for cost?
    def map_key key
      k = key_mapping[key.to_sym]    
      mapped = k == nil ? key : k
      mapped == 'size' ? preferences.area_unit : mapped
    end

    def key_mapping
      {
        location: 'full_address',        
        total_rent: 'cost',
        # cost:     'total_rent'
      }
    end

    alias_method :normalized_criteria, :criteria_hash

    def room?
      @room ||= criteria_hash.type == 'room'
    end

    def furnishments
      %w{unfurnished furnished}
    end

    def types
      %w{room apartment villa house house_boat}
    end        

    # override by subclass!
    def map_value key, value
      value
    end
  end
end
