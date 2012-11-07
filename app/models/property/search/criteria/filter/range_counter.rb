class Property::Criteria::Filter
  class RangeCounter < FieldCounter
    def range_field_limits hash
      hash.inject({}) do |res, (field, options)|
        res.merge! field => range_limits(field, options)
      end
    end

    def range_limits field, options = {}
      field_range = range field

      min = field_range.min
      max = field_range.max
      range_span = max - min

      ranges = []
      min_step = options[:min_step] || 10
      max_steps = options[:max_steps] || 5

      div = (range_span/max_steps).to_i
      div = min_step if div < min_step

      mod = range_span % max_steps
      div_min = (div/2).to_i

      while mod >= div_min
        mod = range_span % (div += 1)
      end

      min_step = div

      done =false
      num = field_range.min
      while num < max && !done
        range = if num >= max - min_step          
          done = true
          Range.new(num, max)
        else
          Range.new(num, num += min_step)
        end
        ranges << range
      end
      
      if ranges.last.span < (ranges.first.span / 2)
        ranges[-1] = Range.new ranges[-1].min, max
        ranges.delete(ranges.last)
      end

      ranges
    end

    def count_ranges range_hash
      range_hash.inject({}) do |res, (field, ranges)|
        hash = {field => {}}
        ranges = [ranges] unless ranges.kind_of?(Array)
        ranges.each do |range|
          hash[field][range.to_s] = count_range(field, range)
        end
        res.merge! hash
      end      
    end

    def count_range field, range
      range_mem[field] ||= search.in(field => range).to_a.size
    end 

    # find numeric ranges
    def ranges *fields
      fields.flatten.inject({}) {|res, field| res.merge! field.to_sym => range(field) }      
    end

    # TODO: fix caching!
    def range_criterias *fields
      fields = range_fields if fields.empty?
      @range_criterias ||= ranges(fields)
    end

    def range_fields
      %w{cost sqm rooms} # .map(&:to_sym)
    end

    def range field
      min(field)..max(field)
    end

    def min field
      search.min(field).to_i
    end

    def max field
      search.max(field).to_i
    end

    protected

    def range_mem
      @range_mem ||= {}
    end
  end
end

