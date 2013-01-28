class Property::Search < BaseSearch
  class Criteria::Builder
    class Base
      attr_reader :search, :type

      include_concerns :mapper, for: 'Property::Search::Criteria::Builder'

      def initialize search, type = nil
        @search = search
        @type = type.to_s if type
      end

      # builds the criteria hash
      def build
        criteria_fields.inject({}) do |criteria_hash, field|
          value = field_value field      
          set_criteria(criteria_hash, field, value) unless skip?(field, value)
          criteria_hash
        end
      end  

      def set_criteria criteria_hash, field, value
        criteria_hash[criteria_field_name(field)] = criteria_for(value)
      end

      def criteria_for value
        value
      end

      def criteria_type
        type || self.class.name.demodulize.sub(/Criteria$/, '')
      end  

      def field_value field
        search.send(field)
      end

      # Filter !?
      def criteria_fields
        search_class.fields_for(criteria_type) # - search_class::Criteria.exclude_fields
      end

      def skip? field, value
        filter(field, value).skip?
      end

      def filter field, value
        @filter ||= search_class::Criteria::Builder::Filter.new field, value
      end

      protected

      def search_class
        Property::Search
      end
    end
  end
end