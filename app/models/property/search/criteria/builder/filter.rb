class Property::Search < BaseSearch
  class Criteria::Builder
    class Filter < BaseSearch::Criteria::Builder::Filter
      def default_field_values
        {type: 'property'}
      end

      def always_use_field?
        field.to_sym == :country_code
      end    
    end
  end
end