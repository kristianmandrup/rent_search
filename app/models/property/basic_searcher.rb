class Property
  class BasicSearcher < Searcher
    def initialize criteria_hash = {}
      puts "BASIC SEARCHER - Searching for: #{clazz}"
      super
    end

    def search    
      clazz.where(where_criteria)
    end
  end
end