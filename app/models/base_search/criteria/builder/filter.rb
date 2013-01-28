class BaseSearch::Criteria::Builder
  class Filter
    attr_reader :field, :value
    attr_writer :default_field_values

    def initialize field, value
      @field, @value = [field, value]
    end

    def skip?
      return false if always_use_field?
      value.blank? || value == 'any' || default_field_value?
    end

    def default_field_value?
      default_field_values[field.to_sym] == value
    end

    def default_field_values
      {}
    end

    def always_use_field?
      false
    end    
  end
end