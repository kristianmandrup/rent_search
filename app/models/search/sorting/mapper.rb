module Search::Sorting
  class Mapper
    # can be used to parse a sorting string from the UI in the form:
    #   direction::field
    # OR
    #   field::direction
    attr_reader :sort_order

    def initialize sorting, options = {}
      # parses sorting into field and direction
      @sort_order = Search::SortOrder.new parse(sorting, options)
    end

    def field
      map! unless mapped?
      calculator.field 
    end

    def direction
      map! unless mapped?
      calculator.direction if mapped?
    end

    def map!
      calculator.calc!
      @mapped = true
    end

    def mapped?
      @mapped
    end
      
    def calculator
      @calculator ||= Search::SortOrder::Calculator.new sort_order
    end

    def parse sorting = nil, options = {}
      parser(sorting, options).parse
    end

    def parser sorting = nil, options = {}
      Search::Sorting::Parser.new sorting, options
    end
  end
end