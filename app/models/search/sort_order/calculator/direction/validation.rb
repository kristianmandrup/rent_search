module Search::SortOrder::Calculator::Direction
  # Can normalize the Sort direction for a sort field
  # Will try to reverse the direction if the direction is not valid for the field
  module Validation
    extend ActiveSupport::Concern

    def valid_direction? dir
      return false if dir.blank?
      valid_directions.include? dir.to_sym
    end    

    def valid_directions
      [:asc, :desc]
    end
  end
end