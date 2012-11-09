class Search::Sorter
  class DirectionCalculator
    attr_reader :sort_field

    include_concerns :direction_normalizer, for 'Search::Sorter'

    # What to do here?
    def initialize sort_field, direction = nil
      @sort_field = sort_field
      @direction = direction

      normalize!
    end
  end
end