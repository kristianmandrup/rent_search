class BaseSearch::Filter
  class SearchApplier < Applier
    protected

    def allowed_classes
      [::BaseSearch]
    end

    def apply_except
      return if except_filter.empty?
      fields.each {|field| reset(field) unless except_filter.include?(field.to_s) || except_filter.include?(field.to_sym) }
    end

    alias_method :search, :obj

    def apply_only      
      only_filter.each {|field| reset field }
    end

    def fields
      search.class.all_fields
    end 

    def reset field
      search.send("#{field}=", nil)
    end
  end
end
