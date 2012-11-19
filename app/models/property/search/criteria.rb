class Property::Search
  class Criteria
    def initialize options = {}
    end

    def builder
      @builder ||= Property::Search::Criteria::Builder.new self
    end

    def mapper criteria_hash, preferences = nil
      Property::Criteria::Mapper.build(criteria_hash, preferences)
    end

    protected

    def subject_clazz
      ::SearchableProperty
    end

    def near_criteria
      [point, radius, units: distance_unit]
    end
  end
end