module Search::Sorter

  # Can normalize the Sort direction for a sort field
  # Will try to reverse the direction if the direction is not valid for the field
  module DirectionNormalizer
    extend ActiveSupport::Concern

    included do
      include_concerns :reverser, for: 'Search::Sorter'      
    end

    def normalize!
      attempt_reverse_direction unless valid_field_direction?(sort_direction)
    end

    def attempt_reverse_direction
      unless valid_field_direction?(reverse!)
        raise ArgumentError, "Field #{sort_field} can not be sorted as it is not listed for any search direction"
      end
    end

    def valid_field_direction? direction
      fields(direction).include? sort_field
    end
  end
end