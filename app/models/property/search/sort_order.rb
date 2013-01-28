class Property::Search  < BaseSearch
  class SortOrder < BaseSearch::SortOrder

    # override generic :created_at
    def self.default_order
      :published_at
    end

    def allow_any_field?
      false
    end    

    def default_options
      {field: :date, direction: :asc}
    end

    def label name
      case name.to_sym
      when :published_at
        :date
      else
        name.to_sym
      end
    end    

    def field_name name
      case name.to_sym
      when :date
        :published_at
      else
        name.to_sym
      end
    end

    def calculator_class
      "Property::Search::SortOrder::Calculator".constantize
    end
  end
end