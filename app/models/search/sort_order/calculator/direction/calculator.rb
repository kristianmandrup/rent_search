module Search::SortOrder::Calculator::Direction
  class Calculator
    attr_reader   :sort_order
    attr_accessor :direction

    include_concern :normalizer, for: 'Search::SortOrder::Calculator::Direction'
    include_concern :validation, for: 'Search::SortOrder'

    # What to do here?
    def initialize sort_order
      @sort_order  = sort_order
      validate_sort_order!      
    end

    def calc! dir = nil
      calc dir
      self
    end

    def calc dir = nil
      @direction = dir || sort_order.direction
      # log_valid
      normalize! unless valid?
      direction
    end

    def valid?
      valid_direction?(direction) && valid_field_direction?(direction)
    end

    def log_valid
      puts "allow_any_field? #{allow_any_field?} dir_fields: #{dir_fields(direction)}"
      puts "valid_direction? #{valid_direction?(direction)} && valid_field_direction? #{valid_field_direction?(direction)}"
    end

    delegate :name, :field, :default_field, :default_direction,  to: :sort_order
    delegate :valid_direction?, :sort_fields_for,                to: :sort_order

    alias_method :sort_direction, :direction
    alias_method :sort_field,     :field
  end
end