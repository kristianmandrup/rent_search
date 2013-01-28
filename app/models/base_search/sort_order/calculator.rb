class BaseSearch::SortOrder
  # Abstract class to perform sorting
  # See fx Property::Search::Sorter for implementation example
  class Calculator
    attr_reader :field, :direction, :sort_order

    include_concerns :direction, :field, :displayer

    # TODO: does not belong here
    include_concern :validation, for: 'BaseSearch::SortOrder::Calculator::Direction'
    include_concern :validation, for: 'BaseSearch::SortOrder::Calculator::Field'

    include_concern :validator, for: 'BaseSearch::SortOrder::Calculator::Direction'

    # Calculates the new sort order given a SortOrder object
    def initialize sort_order = nil
      sort_order ||= BaseSearch::SortOrder.new
      unless sort_order.kind_of?(BaseSearch::SortOrder)
        raise ArgumentError, "Must be a BaseSearch::SortOrder" 
      end
      @sort_order = sort_order
    end

    def self.build field, dir
      self.new BaseSearch::SortOrder.new(field, dir)
    end

    alias_method :sort_field,     :field
    alias_method :sort_direction, :direction

    delegate :name, to: :sort_order

    def calc!
      @field      = calc_field_name
      @direction  = calc_direction
      self
    end
    alias_method :calc, :calc!

    def default_sort_field
      :created_at
    end
    alias_method :default_field, :default_sort_field

    def default_direction
      :asc
    end    
    alias_method :default_sort_direction, :default_direction

    protected

    def sort_fields_for dir = :asc
      raise ArgumentError, "Invalid direction: #{dir}" unless valid_direction? dir
      send "#{dir}_fields"
    end

    def asc_fields
      []
    end

    def desc_fields
      []
    end

    def sort_fields
      (asc_fields | desc_fields).map(&:to_sym)
    end
  end
end