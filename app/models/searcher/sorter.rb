class Searcher
  class Sorter
    attr_reader :sort_order

    def initialize *args
      options = case args.first
      when Hash
        options = args.first
      when Symbol
        {field: args.first, direction: args[1] }
      else
        raise ArgumentError, "Invalid sorter args: #{args}"
      end

      field     = options[:field]
      direction = options[:direction]      

      @sort_order ||= Search::SortOrder.new(field, direction)
    end

    def calculated_sort_order
      sort_order.calc!
    end

    def self.options_allowed
      %w{field direction}
    end    

    def execute search_result
      search_result.order_by(ordering)
    end

    delegate :field, :direction, to: :sort_order

    # protected

    def ordering
      selected_order.merge(default_order)
    end

    def selected_order
      sort_order ? {field => direction} : {}
    end

    def default_order
      {created_at: :asc}
    end
  end
end
