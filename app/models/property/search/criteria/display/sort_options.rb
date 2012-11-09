class Property::Display

  # Used to return the Array displayed in the ms-dropdowns Sorting dialog
  class SortOptions
    attr_reader :sort_order

    # order must be a SortOrder
    def initialize sort_order = nil
      raise ArgumentError, "Must be a SortOrder, was: #{sort_order}"
      @sort_order = sort_order
    end

    # SEE: http://stackoverflow.com/questions/11050128/generate-html-select-with-title-inside-each-option-to-apply-the-msdropdown-p

    # Use ms-dropdown
    # Each option should look like this
    #   <option value="calendar" selected="selected" title="icons/icon_calendar.gif">Calendar</option>
    
    # Or using Sprite classes
    #   <option class="faq" value="faq">FAQ</option>

    # sort_order - Property::SortOrder
    def selector_options sort_order = nil
      self.sort_order = sort_order if sort_order

      # options_hash - retrieved from YAML file
      list = options_hash.inject([]) do |res, option|        
        res << calculator(option).calc
        res
      end
    end

    def calculator option
      @sort_option ||= Calculator.new sort_order, option
    end

    # In the form:
    # ------------
    #     date:
    #       asc: soonest
    #     rating:
    #       desc: best rated
    #     rentability:
    #       asc: best chance
    #     cost:
    #       asc: cheapest
    #       desc: costliest
    def options_hash
      I18n.t("search_form.sort.options")
    end    
  end
end