# Use min max ranges from locale file
class Property::Search::Criteria::Mapper::Ranges
  class Normalizer
    attr_reader :key, :value
    
    def initialize key, value
      @key = key
      @value = value
    end

    def normalized
      @normalized ||= valid_range? ? range : normalized_range(range)
    rescue Exception => e 
      puts e.message
      value
    end

    def normalized_range range
      norm_range = range_map[key.to_sym]
      min = norm_range.cover?(range.min) ? range.min : norm_range.min
      max = norm_range.cover?(range.max) ? range.max : norm_range.max
      Range.new min, max
    rescue Exception => e
      puts e.message      
      norm_range
    end

    def range
      @range ||= range_of(value)
    end

    def valid_range?
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
      unless valid_parsed_range? parsed_range
        raise ArgumentError, "Range must be a string of the form: 'x-y', '+x' or 'x-' where x (and y) are whole numbers, for #{key} was: #{value}"
      end
      Range.new parsed_range.first, parsed_range.last
    end

    def parsed_range
      @parsed_range ||= a_range(value) || more_than(value) || less_than(value)
    end

    def less_than value
      parse_minus(value) if less_expr? value
    end

    def more_than value
      parse_plus(value) if more_expr? value
    end

    def valid_parsed_range? arr
      !arr.blank? && arr.kind_of?(Array) && !(arr.first == nil)
    end

    def more_expr? value
      value =~ /^\+\s*\d/
    end

    def less_expr? value
      value =~ /\d\s*-$/
    end

    def separators
      ['-', ':']
    end

    def a_range value
      separators.map {|s| try_separator(value, s) }.compact.first
    end

    def try_separator value, separator
      value.split(separator).map(&:to_i) if value =~ sep_expr(separator)
    end

    def sep_expr separator
      /\d\s*#{separator}\s*\d/
    end

    def parse_plus value
      [value.to_i, 900000000]
    end    

    def parse_minus value
      [0, value.to_i]
    end    
  end
end