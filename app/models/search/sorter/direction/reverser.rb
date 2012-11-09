module Search::Sorter::Direction
  # Can reverse the sorting direction
  module Reverser
    extend ActiveSupport::Concern

    def reverse
      sort_direction == :asc ? :desc : :asc
    end

    def reverse!
      @sort_direction = reverse
    end
  end
end