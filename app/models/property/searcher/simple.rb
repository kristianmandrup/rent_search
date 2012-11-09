class Property::Searcher
  class Basic < Base
    def initialize options = {}
      puts "BASIC SEARCHER - Searching for: #{clazz}"
      super
    end

    def search    
      clazz.where(where_criteria)
    end
  end
end