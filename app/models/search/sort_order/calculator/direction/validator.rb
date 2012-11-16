module Search::SortOrder::Calculator::Direction
  # Can normalize the Sort direction for a sort field
  # Will try to reverse the direction if the direction is not valid for the field
  module Validator
    extend ActiveSupport::Concern

    include_concern :validation, for: 'Search::SortOrder::Calculator::Direction'

    def validate_direction!
      set_default! unless valid_direction? direction
    end

    def set_default!
      @direction = default_direction
      self
    end

    def valid_field_direction? dir
      dir_fields(dir).include? field.to_s
    end

    def dir_fields dir
      sort_fields_for(dir).map(&:to_s)
    end
  end
end
