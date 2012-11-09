module Property::Search::Display::SortOptions
  # This class is used to Calculate the new select options 
  # for the Sorting dropdown menu
  class Calculator
    attr_reader :dir, :name, :label, :field_name, :dir_labels
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
    end

    alias_method :field, :field_name

    def calc
      option = sort_field_for :asc
      option ? option : sort_field_for(:desc)
    end

    def sort_field direction
      @direction = direction
      # :asc, {asc: 'soonest'} ===> 'soonest'
      @label = dir_labels[dir]    

      return nil if !select_field? || !label
      select_option
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
      (default_dir_label? && !chosen_direction) || 
      reverse_direction? || 
      special_field?
    end

    def reverse_direction?
      reverse_chosen_direction == direction
    end

    def special_field? field
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

    def default_dir_label?
      return false if !label      
      defaults_for(direction).include? label.to_sym
    end

    def defaults_for
      sort_order.send(direction)
    end
  end
end