class Property::Search::Criteria::Display::SortOptions
  # This class is used to Calculate the new select options 
  # for the Sorting dropdown menu
  class Calculator
    attr_reader :direction, :name, :label, :field_name, :dir_labels
    attr_reader :sort_order

    # sort order is a SortOrder object
    # option is fx ['date', {asc: 'soonest'}]
    def initialize sort_order, option
      unless sort_order.kind_of?(Search::SortOrder)
        raise ArgumentError, "Must be a Search::SortOrder, was: #{sort_order}"
      end    

      raise ArgumentError, "Must be an Array, was: #{option}" unless option.kind_of?(Array)
      raise ArgumentError, "Must be a Hash, was: #{option.last}" unless option.last.kind_of?(Hash)

      @sort_order = sort_order
      @name       = option.first
      @dir_labels = option.last # {asc: 'soonest'}
      @field_name = sort_order.field_name(name)
      calc
    end

    alias_method :field, :field_name

    # for each field, first try asc
    # if it is valid, then don't try for desc
    def calc
      sort_field_for(default_field_direction) || sort_field_for(reverse_default_field_direction)
      # raise "Label could not be calculated for #{dir_labels}, #{direction}" if label.nil?
      self
    end

    def sort_field_for dir      
      @direction ||= dir # if label # dir_calculator.calc(dir)
      
      return nil if !select_field?
      select_option
    end

    delegate :allow_any_field?, :default_field_directions, to: :sort_order

    def default_field_direction
      default_field_directions[name.to_sym]
    end

    def reverse_default_field_direction
      default_field_direction == :asc ? :desc : :asc
    end

    # def dir_calculator
    #   @dir_calculator ||= Search::SortOrder::Calculator::Direction::Calculator.new sort_order
    # end

    def select_option
      [sort_label, option_value, option_attributes]
    end

    def option_attributes
      {:'class' => "#{sort_direction}ending"}
    end

    def option_value
      "#{name}::#{sort_direction}"
    end

    def sort_label
      dir_labels[sort_direction]
    end

    def sort_direction
      reverse_chosen_direction || direction
    end

    def sort_order_name
      sort_order.name.to_s
    end

    def select_field?
      wtf? || reverse_direction?
    end

    def wtf?
      default_dir_label? && !chosen_direction
    end

    # does the current option direction match the reverse sort order direction?
    # note: only applies if option field also matches sort order
    def reverse_direction?
      reverse_chosen_direction == direction
    end

    # does the current sort order field name match the option field name
    # being calculated?
    def matching_sort_order?
      name.to_s == sort_order_name
    end

    # reverse the sort order if the option field matches 
    # the current sort order
    def reverse_chosen_direction
      reverse_sort_order.direction.to_sym if matching_sort_order?
    end

    def reverse_sort_order
      @reverse_sort_order ||= sort_order.reverse!
    end

    # return the sort order direction if option field matches sort order field
    def chosen_direction
      sort_order.direction.to_sym if matching_sort_order?
    end

    # If the current label and direction is included in the asc or desc_fields
    def default_dir_label?
      # return false if !label
      direction_fields.include? name.to_sym
    end

    def direction_fields
      sort_order.send("#{direction}_fields")
    end
  end
end