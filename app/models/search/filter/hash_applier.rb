class Search::Filter
  class HashApplier
    attr_reader :filter, :hash

    def initialize filter, hash
      raise ArgumentError, "Must be a kind of Hash" unless hash.kind_of?(Hash)
      @filter = filter
      @hash = hash
    end

    def apply 
      apply_except   
      apply_only
      hash
    end 

    def to_s
      %Q{
hash:   #{hash}
filter: #{filter}
}
    end

    delegate :only_filter, :except_filter, to: :filter

    protected

    def apply_except
      @hash.keep_only! except_filter
    end

    def apply_only
      @hash.delete_keys! only_filter
    end
  end
end
