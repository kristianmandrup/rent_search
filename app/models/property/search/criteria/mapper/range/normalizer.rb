# Use min max ranges from locale file
class Property::Search::Criteria::Mapper
  class Normalizer
    attr_reader :key, :value
    
    def initialize key, value
      @key = key
      @value = value
    end

    def normalized
      @normalized ||= valid_range? ? range : normalized_range
    rescue Exception => e 
      # puts e.message
      value
    end

    def normalized_range
      @normalized_range ||= range_map[key.to_sym]
    end

    def range
      @range ||= range_of(value)
    end

    def valid_range?
      normalized_range.covers? range
    end

    # TODO: load from search_form!
    def range_map
      @range_map ||= I18n.t('search_form.ranges').inject({}) do |res, (key, value)|
        range = value.split('-').map(&:to_i)
        res.merge! key => Range.new(range.first, range.last)
      end
    end    

    protected

    def range_of value
      arr = value.split(':') if value =~ /:/
      arr = value.split('-') if value =~ /-/
      unless arr.kind_of?(Array)
        raise ArgumentError, "Range must be a string of the form: x-y where x and y are integer numbers, for #{key} was: #{value}"
      end
      Range.new arr.first.to_i, arr.last.to_i
    end    
  end
end