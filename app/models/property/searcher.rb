class Property
  class Searcher < ::Searcher
    attr_reader :criteria, :criteria_hash, :order, :page

    def initialize options = {}
      @order = Property::Order.new options.delete(:order)
      
      @paged = options[:paged]
      @page  = (options.delete(:page) || 1) if paged?

      options.delete(:page)

      @criteria_hash = options
      configure!
    end

    # TODO: Use scopes ?
    def execute
      @results ||= paged? ? paged(search) : search
    end

    def paged?
      @paged
    end

    def search
      ordered(criteria_search)
    end

    def criteria_search
      criteria.search
    end

    def paged search_result
      search_result.page(page)
    end

    def ordered search_result
      search_result.send(order.direction, order.field).asc(:published_at)
    end

    def to_s
      %Q{
Searcher:
criteria: #{criteria_hash}
order: #{order}
page: #{page}
}
    end

    protected

    delegate :where_criteria, :near_criteria, to: :criteria

    def clazz
      Property
    end

    def configure!
      build_criteria
    end

    def build_criteria
      @criteria ||= Property::Criteria.build_from criteria_hash
    end
  end
end