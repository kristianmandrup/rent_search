class Search::Filter
  class HashApplier
    attr_reader :filter, :hash

    def initialize filter, hash
      @hash = hash
    end

    def apply
      raise ArgumentError, "Must be a kind of Hash" unless search.kind_of?(Hash)
      apply_except      
      apply_only
    end 

    protected

    def apply_except
      hash.delete_keys! filter.except
    end

    def apply_only
      hash.keep_only filter.only
    end
  end
end
