module BaseSearch::SortOrder::Calculator::Direction
  # Can normalize the Sort direction for a sort field
  # Will try to reverse the direction if the direction is not valid for the field
  module Validator
    extend ActiveSupport::Concern

    include_concern :validation, for: 'BaseSearch::SortOrder::Calculator::Direction'

    def allow_any_field?
      sort_order.allow_any_field? if respond_to? :sort_order
    end

    def validate_direction!
      set_default! unless valid_direction? direction
    end

    def set_default!
      @direction = default_direction
      self
    end

    def valid_field_direction? dir
      return true if allow_any_field?
      dir_fields(dir).include? name.to_sym
    end

    def dir_fields dir
      sort_fields_for(dir).map(&:to_sym)
    end
  end
end
