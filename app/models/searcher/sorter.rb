class Searcher
  class Sorter
    attr_reader :order

    def initialize options = {}
      @order = Search::SortOrder.new options.delete(:order)
    end

    def execute search_result
      search_result.order_by(ordering)
    end

    protected

    def ordering
      selected_order.merge(default_order)
    end

    def selected_order
      order ? {order.field => order.direction} : {}      
    end

    def default_order
      {published_at: :asc}
    end
  end
end
