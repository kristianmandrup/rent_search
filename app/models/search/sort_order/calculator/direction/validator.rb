module Search::SortOrder::Calculator::Direction
  # Can normalize the Sort direction for a sort field
  # Will try to reverse the direction if the direction is not valid for the field
  module Validator
    extend ActiveSupport::Concern

    include_concern :validation, for: 'Search::SortOrder::Calculator::Direction'

    delegate :allow_any_field?, to: :sort_order

    def validate_direction!
      set_default! unless valid_direction? direction
    end

    def set_default!
      @direction = default_direction
      self
    end

    def valid_field_direction? dir
      return true if allow_any_field?
      dir_fields(dir).include? field.to_s
    end

    def dir_fields dir
      sort_fields_for(dir).map(&:to_s)
    end
  end
end
