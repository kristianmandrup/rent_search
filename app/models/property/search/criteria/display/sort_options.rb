class Property::Search < BaseSearch
  class Criteria::Display
    # Used to return the Array displayed in the ms-dropdowns Sorting dialog
    class SortOptions
      attr_reader :sort_order

      # order must be a SortOrder
      def initialize sort_order = nil
        self.sort_order = sort_order
      end

      def self.build_default
        self.new
      end

      def sort_order= sort_order
        sort_order ||= sort_order_class.new
        unless sort_order.kind_of?(sort_order_class)
          raise ArgumentError, "Must be a #{sort_order_class}, was: #{sort_order}"
        end      
        @sort_order = sort_order
      end

      def sort_order_class
        "Property::Search::SortOrder".constantize
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
          select_option = calculator(option).select_option
          res << select_option
          res
        end
      end
      alias_method :options, :selector_options 

      delegate :allow_any_field?, to: :sort_order

      def calculator option
        Calculator.new sort_order, option
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
        I18n.t("property.sort.options")
      end    
    end
  end
end