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
        res.merge! key => send("normalize", key, value)
      end
    end

    def normalize key, value
      Normalizer.new(key, value).normalized
    end    
  end
end