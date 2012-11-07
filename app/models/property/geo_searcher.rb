class Property
  class GeoSearcher < Searcher
    def initialize criteria_hash = {}
      puts "GEO SEARCHER - Searching for: #{clazz}"
      super
    end

    def search
      clazz.near(*near_criteria)
    end
  end
end