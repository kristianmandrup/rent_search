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
        invalid_field = sort_order.valid_field_name? ? "" : "invalid field: #{sort_order.field}"
        invalid_dir = sort_order.valid_dir? ? "" : "invalid dir: #{sort_order.direction}"

        suggestion = ""
        if !invalid_field.blank? 
          suggestion += "Perhaps you forgot to set a calculator_class on SortOrder where the class has :asc_fields and :desc_fields methods" 
        end
        if !invalid_dir.blank?           
          suggestion += "Try another direction"
        end

        raise ArgumentError, "Invalid sort order: #{sort_order}, #{invalid_field} #{invalid_dir} #{suggestion}"
      end      
    end      
  end
end