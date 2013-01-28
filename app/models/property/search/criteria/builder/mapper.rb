class Property::Search < BaseSearch
  class Criteria::Builder
    module Mapper
      def criteria_field_name field
        field_name = real_field_name(field)
        address_fields.include?(field_name) ? "address.#{field_name}" : field_name.to_s
      end

      def real_field_name(field)
        case field.to_sym
        when :full_address
          :position
        when :total_rent, :cost
          :cost
        else
          field.to_sym
        end
      end

      def address_fields
        [:country_code]
      end  

      def period_field
        :dates
      end        
    end
  end
end