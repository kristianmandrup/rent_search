class Search

  # Abstract class to perform sorting
  # See fx Property::Search::Sorter for implementation example
  class Sorter
    attr_reader :field_name, :direction

    include_concerns :direction_calculator

    # Calculates the new sort order given a field name

    # See orderer_spec
    # Property::Orderer.new :rating
    # direction is :desc

    # Property::Orderer.new :cost
    # direction is :asc

    def initialize name = nil, direction = nil
      @field_name = calc_field_name(name).to_s
      @direction  = calc_direction(direction)
    end

    protected

    def calc_direction direction
      direction_calculator(field_name, direction)
    end 

    def calc_field_name name
      field_calculator.calc(name).to_s
    end

    def field_calculator
      FieldCalculator.new sort_field, sort_direction
    end

    def direction_calculator
      DirectionCalculator.new sort_field, sort_direction
    end

    def fields dir = :asc
      send "#{dir}_fields"
    end

    def asc_fields
      []
    end

    def desc_fields
      []
    end
  end
end