class Search::Filter
  class Applier
    attr_reader :filter, :search

    def initialize filter, search
      @search = search
    end

    def apply
      raise ArgumentError, "Must be a kind of Search" unless search.kind_of?(Search)
      apply_except      
      apply_only
    end 

    protected

    def apply_except
      except_filter.each {|field| reset field }
    end

    def apply_only
      search.class.all_fields.each {|field| reset(field) unless only_filter.include?(field) }
    end

    def reset field
      search.send("#{field}=", nil)
    end      
  end
  end
end
