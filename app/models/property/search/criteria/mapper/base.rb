class Property::Search::Criteria::Mapper
  class Simple < Base
    attr_reader :criteria_hash, :preferences

    def initialize criteria_hash, preferences = nil
      @criteria_hash = Hashie::Mash.new criteria_hash

      preferences ||= Property::Criteria::Preferences.new
      unless preferences.kind_of?(Property::Criteria::Preferences)
        raise ArgumentError, "Must be a Property::Criteria::Preferences, was: preferences"
      end
      @preferences = preferences

      raise "No area unit defined in preferences" if preferences.area_unit.blank?
      raise "No currency defined in preferences" if preferences.currency.blank?
    end

    def mapped_hash
      normalized_criteria.inject({}) do |res, (key, value)|
        mapped = map(key, value)
        res.merge!(mapped) if mapped
        res
      end
    end

    protected

    delegate :currency, :area_unit, to: :preferences

    def map key, value
      key = map_key(key)
      mapped =  map_value(key, value)
      return nil if !mapped
      {key => mapped}
    end

    def map_key key
      k = key_mapping[key.to_sym]
      k == nil ? key : k
    end

    def key_mapping
      {
        location: :full_address,
        cost:     :total_rent
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