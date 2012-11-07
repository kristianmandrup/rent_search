class Search
  module Sortable
    extend ActiveSupport::Concern

    included do
      field :sort, type: String, default: default_sort
    end

    def sort= value
      value = self.class.default_sort unless valid_sort_order? value
      super(value)
    end

    def valid_sort_order? order
      valid_sort_orders.include? order.to_s
    end

    def valid_sort_orders
      self.class.valid_sort_orders
    end

    module ClassMethods
      def default_sort
        valid_sort_orders.first
      end

      def valid_sort_orders
        @valid_sort_orders ||= map_direction(:asc) + map_direction(:desc)
      end

      def map_direction dir = :asc
        direction(dir).map{|name| "#{dir}::#{name}"}
      end

      def direction dir = :asc
        return both_directions if dir == :both
        send("#{dir}_enders")
      end

      def both_directions
        @both_directions ||= ascenders & descenders
      end      
    end      
  end
end