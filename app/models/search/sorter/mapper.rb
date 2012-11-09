module Search::Sorter
  class Mapper
    # maps field::direction to field and direction
    attr_reader :sort_field, :sort_direction, :separator, :parser_type

    # After mapping the sorting values can be displayed!
    include_concerns :displayer

    # sorting is a string in the form
    #   sort_field::sort_direction or sort_direction::sort_field

    # another separator such as '-' can also be configured
    # it is recommended however not to pass the sorting in this format,
    #  but to pass in the sort params individually as :sort_field and :sort_direction

    def initialize sort_field, sort_direction, options = {}            
      @sort_field, @sort_direction = [sort_field, sort_direction]
      normalize!

      configure options
    end

    def configure options
      @parser_type  = options[:parser]    || default_parser_type
      @separator    = options[:separator] || default_separator
    end  

    def default_parser_type
      :dir_field
    end

    def default_separator
      '::'
    end
  end
end