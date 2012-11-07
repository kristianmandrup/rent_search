class Property
  class SortOptions
    attr_reader :order

    def initialize order = nil
      # TODO: move to initialize
      order ||= Property::Order.new
      self.order = order
    end

    def order= order
      @order = case order
      when Property::Order
        order
      when Symbol, String
        Property::Order.new order
      else
        raise ArgumentError, "Must be a Property::Order, was: #{current_order}"
      end      
    end

    # SEE: http://stackoverflow.com/questions/11050128/generate-html-select-with-title-inside-each-option-to-apply-the-msdropdown-p

    # Use ms-dropdown
    # Each option should look like this
    #   <option value="calendar" selected="selected" title="icons/icon_calendar.gif">Calendar</option>
    
    # Or using Sprite classes
    #   <option class="faq" value="faq">FAQ</option>

    # current_order: Property::Order
    def options order = nil
      self.order = order if order

      # options_hash
      list = options_hash.inject([]) do |res, option|        
        name = option.first
        dir_labels = option.last

        res << add_sort_field(:asc, name, dir_labels)
        res << add_sort_field(:desc, name, dir_labels)

        res
      end.compact
    end

    # protected

    # TODO: avoid passing array as last argument!
    def add_sort_field dir, name, dir_labels
      label = dir_labels[dir]
      field = order.mapped(name)
      
      if select_field? dir, field, name
        return nil if !label

        option_item = [label, "#{name}::#{dir}", :'class' => "#{dir}ending"]
        return option_item
      end
      nil
    end

    def select_field? dir, field, name
      (default_dir_label?(dir, field) && !chosen_direction(name)) || reverse_chosen_direction(name) == dir || special_field?(field)
    end

    def special_field? field
      %w{date rating}.include? field.to_s
    end

    def reverse_chosen_direction name
      order.reverse.to_sym if name.to_s == order.name.to_s
    end

    def chosen_direction name
      order.direction.to_sym if name.to_s == order.name.to_s
    end


    def default_dir_label? direction, label
      return false if !label      
      defaults_for(direction).include? label.to_sym
    end

    def defaults_for direction 
      order.send(direction)
    end

    def options_hash
      I18n.t("search_form.sort.options")
    end    
  end
end
