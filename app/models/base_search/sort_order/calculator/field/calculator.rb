module BaseSearch::SortOrder::Calculator::Field
  class Calculator
    attr_reader   :sort_order
    attr_accessor :field_name

    include_concerns :validation, for: 'BaseSearch::SortOrder::Calculator::Field'
    include_concern  :validation, for: 'BaseSearch::SortOrder'

    # Calculate the sort field
    # sort_order - Search::SortOrder
    def initialize sort_order
      @sort_order = sort_order
      validate_sort_order!      
    end

    def calc name = nil
      @field_name = name.blank? ? field : name
      puts "normalize: #{field_name}"
      normalize_name!
    end

    protected

    def normalize_name!
      @field_name = valid_field?(field_name) ? field_name : default_field
    end

    delegate :name, :direction, :field, :default_field, to: :sort_order
  end
end