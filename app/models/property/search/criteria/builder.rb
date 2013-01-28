class Property::Search < BaseSearch
  class Criteria
    class Builder
      attr_reader :search

      include_concerns :mapper

      def initialize search
        raise ArgumentError, "Must be a Search, was: #{search}" unless search.kind_of?(::BaseSearch)
        @search = search
      end

      def where_criteria
        @where_criteria ||= type_builders.inject({}) do |res, type|
          criteria = builder_for(type).build
          res.merge! criteria unless criteria.blank?
          res
        end
      end

      def builder_for type
        return empty_builder unless type_builder? type
        builder_for?(type) ? make_builder(type) : base_builder(type)
      end

      # protected

      def type_builder? type
        type_builders.include?(type)
      end    

      def type_builders
        search_class.criteria_types - [:geo]
      end

      def make_builder type
        builder_class_for(type).new search, type
      end

      def builder_class_for type
        builder_class_name_for(type).constantize
      end

      def builder_class_name_for type
        "Property::Search::Criteria::Builder::#{type.to_s.camelize}Criteria"
      end

      EmptyBuilder = Struct.new(:build)

      def empty_builder
        EmptyBuilder.new({})
      end

      def base_builder type
        criteria_class::Builder::Base.new search, type
      end

      def criteria_class
        search_class::Criteria
      end

      def search_class
        Property::Search
      end

      # Builders that have a specific class
      def builder_for? type
        criteria_builders.include? type.to_sym
      end

      # If type is not in this list it is simple and can just use Base directly!
      def criteria_builders
        [:list, :range, :timespan]
      end
    end
  end
end