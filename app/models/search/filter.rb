class Search
  class Filter
    attr_reader :filter

    def initialize filter = []
      @filter = filter
    end

    def apply_on search
      raise ArgumentError, "Must be a kind of Search" unless search.kind_of?(Search)
      filter.each {|field| reset field }
    end 

    def reset field
      search.send("#{field}=", nil)
    end
  end
end
