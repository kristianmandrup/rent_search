module Search::SortOrder::Calculator::Direction
  # Can reverse the sorting direction
  module Reverser
    extend ActiveSupport::Concern

    def reverse
      direction == :asc ? :desc : :asc
    end

    def reverse!
      @direction = reverse
      normalize!
      self
    end
  end
end