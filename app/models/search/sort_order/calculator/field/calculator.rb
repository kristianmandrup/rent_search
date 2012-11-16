module Search::SortOrder::Calculator::Field
  class Calculator
    attr_reader   :sort_order
    attr_accessor :field_name

    include_concerns :validation, for: 'Search::SortOrder::Calculator::Field'
    include_concern  :validation, for: 'Search::SortOrder'

    # Calculate the sort field
    # sort_order - Search::SortOrder
    def initialize sort_order
      @sort_order = sort_order
      validate_sort_order!      
    end

    def calc name = nil
      @field_name ||= name || field
      @field_name = normalized_name.to_sym
    end

    protected

    def normalized_name
      valid_field?(field_name) ? field_name : default_field
    end

    delegate :direction, :field, :default_field, to: :sort_order
  end
end