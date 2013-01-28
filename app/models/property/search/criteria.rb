class Property::Search < BaseSearch
  class Criteria
    attr_reader :search

    def initialize search
      @search = search
    end

    def construct search = nil
      @builder = builder_class.new search if search

      builder.where_criteria
    end

    def builder
      @builder ||= builder_class.new search
    end

    def mapper criteria_hash, preferences = nil
      mapper_class.build(criteria_hash, preferences)
    end

    protected

    def mapper_class
      Property::Search::Criteria::Mapper
    end

    def builder_class
      Property::Search::Criteria::Builder
    end

    def subject_clazz
      ::SearchableProperty
    end

    def near_criteria
      [point, radius, units: distance_unit]
    end
  end
end