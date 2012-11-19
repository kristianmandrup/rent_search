class Property
  class Searcher < ::Searcher
    def criteria_class
      Property::Search::Criteria
    end
  end
end