class Property::Searcher
  class Geo < Base
    def initialize options = {}
      super
    end

    def search
      clazz.near(*near_criteria)
    end

    def near_criteria
      [point, radius, units: distance_unit]
    end
  end
end
