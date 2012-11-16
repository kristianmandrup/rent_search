class Search::SortOrder::Calculator
  module Field
    extend ActiveSupport::Concern

    # Used by Search::Sorter which has a sort order
    def field_calculator
      @field_calculator ||= Calculator.new sort_order
    end

    def calc_field_name
      field_calculator.calc # (field)
    end    
  end
end