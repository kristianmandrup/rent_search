class Property::Search::Criteria
  class Builder
    attr_reader :search

    def initialize search, options = {}
      @search = search
    end

    def where_criteria
      @where_criteria ||= criteria_types.inject({}) do |res, type|
        criteria_method = "#{type}_criteria"

        sub_criteria = send(criteria_method) if respond_to?(criteria_method)
        res.merge! sub_criteria unless sub_criteria.blank?
        res
      end
    end

    protected

    def builder_for type
      builder_for?(type) ? make_builder(type).build : base_builder(type).build
    end

    def make_builder type
      "Property::Search::Criteria::Builder::#{type}".constantize.new search, type
    end

    def base_builder type
      Property::Search::Criteria::Builder::Base.new search, type
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