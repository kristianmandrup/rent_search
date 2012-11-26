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
      raise ArgumentError, "Mut be a Hash, was: #{option.last}" unless option.last.kind_of?(Hash)

      @sort_order = sort_order
      @name       = option.first
      @dir_labels = option.last # {asc: 'soonest'}
      @field_name = sort_order.field_name(name)
      calc
    end

    alias_method :field, :field_name

    def calc
      sort_field_for(:asc) || sort_field_for(:desc)
      raise "Label could not be calculated for #{dir_labels}, #{direction}" if label.nil?
      self
    end

    def sort_field_for dir
      @direction = dir_calculator.calc(dir)

      @label ||= dir_labels[direction.to_sym]      
      
      return nil if !select_field? || !label
      select_option
    end

    delegate :allow_any_field?, to: :sort_order

    def dir_calculator
      @dir_calculator ||= Search::SortOrder::Calculator::Direction::Calculator.new sort_order
    end

    def select_option
      [label, option_value, option_attributes]
    end

    def option_attributes
      {:'class' => "#{direction}ending"}
    end

    def option_value
      "#{name}::#{direction}"
    end

    def sort_order_name
      sort_order.name.to_s
    end

    def select_field?
      wtf? || 
      reverse_direction? || 
      special_field?
    end

    def wtf?
      default_dir_label? && !chosen_direction
    end

    def reverse_direction?
      reverse_chosen_direction == direction
    end

    def special_field?
      %w{date rating}.include? field_name.to_s
    end

    def matching_sort_order?
      name.to_s == sort_order_name
    end

    def reverse_chosen_direction
      sort_order.reverse.to_sym if matching_sort_order?
    end

    def chosen_direction
      sort_order.direction.to_sym if matching_sort_order?
    end

    # If the current label and direction is included in the asc or desc_fields
    def default_dir_label?
      return false if !label      
      direction_labels.include? label.to_sym
    end

    def direction_labels
      sort_order.send("#{direction}_fields")
    end
  end
end