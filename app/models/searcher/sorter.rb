class Searcher
  class Sorter
    attr_reader :sort_order

    def initialize options = {}
      @sort_order = Search::SortOrder.new options.delete(:order)
    end

    def execute search_result
      search_result.order_by(ordering)
    end

    protected

    def ordering
      selected_order.merge(default_order)
    end

    def selected_order
      sort_order ? {sort_order.field => sort_order.direction} : {}      
    end

    def default_order
      {created_at: :asc}
    end
  end
end
