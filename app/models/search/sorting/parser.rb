module Search::Sorting
  # Can parse a sorting String in the form
  #   field::direction
  # OR    
  #   direction::field

  # Can be used to parse a sorting params received from the UI
  class Parser
    attr_reader :field, :direction, :sorting, :separator, :type

    # Used to swap direction and field
    include_concerns :swapper

    def initialize sorting, options = {}
      @sorting = sorting
      @separator = options[:separator] || default_separator
      @type = options[:type] || default_type
    end

    # Parses string into [field, direction] which are set and also returned
    def parse
      @field, @direction = ordered_sort_items
      swap! if direction?(field)
      {field: field.to_s, direction: direction.to_s }
    end

    protected

    def default_type
      :field_dir
    end

    def default_separator
      '::'
    end

    def ordered_sort_items
      type == :field_dir ? sort_items : sort_items.reverse
    end

    def sort_items
      @sort_items ||= sorting.split(separator)
    end
  end
end
