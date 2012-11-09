class Property
  class Searcher < ::Searcher
    def builder_class
      Property::Search::Builder
    end
  end
end