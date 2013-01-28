class BaseSearch::Filter
  class Applier
    attr_reader :filter, :obj

    def initialize filter, obj
      @filter = filter
      @obj    = obj      
      raise ArgumentError, "Must be one of #{allowed_classes.join(',')}" unless allowed_class?
    end

    def apply 
      apply_except   
      apply_only
      obj
    end 

    def to_s
      %Q{
obj:    #{obj}
filter: #{filter}
}
    end

    delegate :only_filter, :except_filter, to: :filter

    protected

    def allowed_class?
      allowed_classes.any? {|clazz| obj.kind_of? clazz }
    end

    def allowed_classes
      [Object]
    end

    def apply_except
      @obj = obj.keep_only! except_filter
    end

    def apply_only
      @obj = obj.delete_keys! only_filter
    end
  end
end
