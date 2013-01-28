class Property::Search < BaseSearch
  class Criteria::Filter
    class FieldCounter
      attr_reader :search

      def initialize search
        raise ArgumentError, "Must be a Mongoid::Criteria" unless search.kind_of?(Mongoid::Criteria)
        @search = search
      end

      def field_selector
        @field_selector ||= filter_class::FieldSelector.new search.to_a
      end

      delegate :values_for, :selected_fields, to: :field_selector

      protected

      def filter_class
        Property::Search::Criteria::Filter
      end
    end
  end
end