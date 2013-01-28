module BaseSearch::SortOrder::Calculator::Direction
  # Can reverse the sorting direction
  module Reverser
    extend ActiveSupport::Concern

    def reverse
      direction == :asc ? :desc : :asc
    end

    def reverse!
      @direction = reverse
      normalize! if respond_to? :normalize!
      self
    end
  end
end