module Search::Sorter::Direction
  class Calculator
    attr_reader :sort_field

    include_concerns :normalizer, for: 'Search::Sorter::Direction'

    # What to do here?
    def initialize sort_field, direction = nil
      @sort_field = sort_field
      @direction = direction

      normalize!
    end
  end
end