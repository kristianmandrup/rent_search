module Search::Sorting
  class Mapper
    # can be used to parse a sorting string from the UI in the form:
    #   direction::field
    # OR
    #   field::direction

    def initialize sorting, options = {}
      # parses sorting into field and direction
      Search::Sort::Mapper.new *(parse sorting, options), options 
    end

    def parse sorting = nil, options = {}
      parser(sorting, options).parse
    end

    def parser sorting = nil, options = {}
      Search::Display::Parser.new sorting, options
    end
  end
end