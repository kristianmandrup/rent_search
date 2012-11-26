class Property::Search::Criteria::Mapper
  class Ranges < Base
    protected

    def map_value key, value
      return nil if !value || value == 'any' || value.blank?
      case key.to_sym
      when :type
        return nil unless types.include?(value.to_s)
        value
      when :furnishment
        return nil unless furnishments.include?(value.to_s)
        value
      else
        value
      end
    end

    # Uses normalizer
    def normalized_criteria
      @normalized_criteria ||= criteria_hash.inject({}) do |res, (key, value)|
        field = map_key(key)
        res.merge! field => calc_value(field, value)
        res
      end
    end

    def calc_value field, value
      return value if value.nil?
      value.trim!
      normalize_range?(field) ? normalize(field, value) : value
    end


    def normalize_range? field
      [:range, :list].include? field_type_of(field)
    end

    def field_type_of field
      Property::Search.field_type_of field
    end

    def normalize key, value
      Normalizer.new(key, value).normalized
    end    
  end
end