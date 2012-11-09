class Property::Search::Criteria
  class Builder
    attr_reader :search

    def initialize search
      @search = search
    end

    def where_criteria
      @where_criteria ||= criteria_types.inject({}) do |res, type|
        criteria = builder_for(type).build
        res.merge! criteria unless criteria.blank?
        res
      end
    end

    protected

    def type_builders
      Property::Criteria.criteria_types - [:geo]
    end

    def builder_for type
      return empty_builder unless type_builder? type
      builder_for?(type) ? make_builder(type).build : base_builder(type).build
    end

    def make_builder type
      "Property::Search::Criteria::Builder::#{type}".constantize.new search, type
    end

    def empty_builder
      builder = Struct.new(:build)
      builder.build = {}
      builder
    end

    def base_builder type
      Property::Search::Criteria::Builder::Base.new search, type
    end

    def type_builder? type
      type_builders.include?(type)
    end

    def builder_for? type
      criteria_builders.include? type.to_sym
    end

    # If type is not in this list it is simple and can just use Base directly!
    def criteria_builders
      [:list, :range]
    end
  end
end