module Search::SortOrder::Calculator::Direction
  # Can normalize the Sort direction for a sort field
  # Will try to reverse the direction if the direction is not valid for the field
  module Normalizer
    extend ActiveSupport::Concern

    included do
      include_concerns :reverser, :validator, for: 'Search::SortOrder::Calculator::Direction'
    end

    def normalize!
      validate_direction!
      attempt_reverse_direction! unless valid_field_direction? direction
      self
    end

    def attempt_reverse_direction!
      if valid_field_direction? reverse
        reverse!
      else
        set_default!
        # raise ArgumentError, "Field #{sort_field} can not be sorted as it is not listed for any search direction"
      end
    end
  end
end