module BaseSearch::Sorting
  class Mapper
    # can be used to parse a sorting string from the UI in the form:
    #   direction::field
    # OR
    #   field::direction
    attr_reader :sort_order

    def initialize sorting, options = {}
      # parses sorting into field and direction
      @sort_order = sort_order_class.new parse(sorting, options)
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
      @calculator ||= calculator_class.new sort_order
    end

    def parse sorting = nil, options = {}
      parser(sorting, options).parse
    end

    def parser sorting = nil, options = {}
      parser_class.new sorting, options
    end

    protected

    def calculator_class
      ::BaseSearch::SortOrder::Calculator
    end

    def parser_class
      ::BaseSearch::Sorting::Parser
    end

    def sort_order_class
      ::BaseSearch::SortOrder
    end
  end
end