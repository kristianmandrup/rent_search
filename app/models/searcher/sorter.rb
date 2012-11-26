class Searcher
  class Sorter
    attr_reader :sort_order

    def initialize *args
      options = options_normalizer(*args).normalize || default_options

      field     = options[:field]
      direction = options[:direction]      

      @sort_order ||= Search::SortOrder.new(field, direction)
    end

    delegate :field, :direction, to: :sort_order

    def options_normalizer *args
      @options_normalizer ||= Searcher::Sort::OptionsNormalizer.new args.flatten
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

    def default_options
      {field: default_order.keys.first, direction: default_order.values.first}
    end

    def default_order
      {created_at: :asc}
    end
  end
end
