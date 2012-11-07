class Property
  class Sorter
    attr_reader :sort_order, :direction

    def initialize sort_order = :published_at
      sort_order = :published_at unless valid_sort_order? sort_order
      @sort_order = sort_order
      @direction = calc_direction
    end

    protected

    def valid_sort_order? sort_order
      valid_orders.include? sort_order
    end

    def valid_orders
      @valid_orders ||= ascenders + descenders
    end

    def calc_direction
      return :asc if ascenders.include? sort_order.to_sym
      return :desc if descenders.include? sort_order.to_sym
      raise ArgumentError, "Sort order attribute: #{order} has no default direction defined"
    end

    def ascenders
      %w{date published_at cost cost_sqm rentability}.map(&:to_sym)
    end

    def descenders
      %w{rating sqm rooms}.map(&:to_sym)
    end
  end
end