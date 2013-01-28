class BaseSearch::SortOrder::Calculator
  module Direction
    extend ActiveSupport::Concern

    def direction_calculator
      Calculator.new sort_order
    end

    def calc_direction
      direction_calculator.calc #direction
    end         
  end
end