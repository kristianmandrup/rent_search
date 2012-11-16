class Search::SortOrder
  module Validation
    extend ActiveSupport::Concern

    def validate_sort_order!
      validate_sort_order sort_order
    end

    def validate_sort_order sort_order    
      unless sort_order.kind_of?(Search::SortOrder)
        raise ArgumentError, "Must be a Search::SortOrder, was: #{sort_order}"
      end
      unless sort_order.valid?
        raise ArgumentError, "Invalid sort order: #{sort_order}"
      end      
    end      
  end
end