# Use min max ranges from locale file
class Property::Search::Criteria::Mapper::Ranges
  class Normalizer
    attr_reader :key, :value
    
    def initialize key, value
      @key = key
      @value = converter(value).convert
    end

    # Return the normal value in case it is not a Range!
    def normalized
      @normalized ||= valid_range? ? range : normalized_range(range)
    rescue Exception => e 
      # puts e.message
      value
    end

    def normalized_range range
      return nil if range.nil?
      norm_range = range_map[key.to_sym]
      min = norm_range.cover?(range.min) ? range.min : norm_range.min
      max = norm_range.cover?(range.max) ? range.max : norm_range.max
      Range.new min, max
    rescue Exception => e
      # puts e.message      
      norm_range
    end

    def range
      @range ||= range_of(value)
    end

    def valid_range?
      return true if range.nil?
      normalized_range(range).covers? range
    end

    # TODO: load from search_form!
    def range_map
      @range_map ||= ranges.inject({}) do |res, (key, value)|
        range = value.split('-').map(&:to_i)
        res.merge! key => Range.new(range.first, range.last)
      end
    end    

    # protected

    def ranges
      @ranges ||= I18n.t('property.ranges')
    end

    # TODO: RangeParser class?

    def range_of value
      return nil if value == 'any' || value.blank?
      unless parser(value).valid?
        raise ArgumentError, "Range must be a string of the form: 'x-y', '+x' or 'x-' where x (and y) are whole numbers, for #{key} was: #{value}"
      end
      parser(value).range
    end

    def parser txt
      @parser ||= Property::Search::Criteria::Mapper::Parser.new txt
    end

    def converter txt
      Property::Search::Criteria::Mapper::Converter.new txt
    end    
  end
end