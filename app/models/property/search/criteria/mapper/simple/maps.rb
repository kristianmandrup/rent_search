class Property::Search::Criteria::Mapper
  class Simple < Base
    module Maps
      def map_for label, value = nil
        case label.to_sym
        when :cost, :rent, :total_rent
          cost_map
        else
          map_meth = "#{label}_map"
          raise ArgumentError, "No map defined for: #{label}" unless respond_to? map_meth
          value ? send(map_meth, value) : send(map_meth)
        end
      end

      def sqfeet_map type = :property
        send("#{type}_sqm_map").map{|range| range.to_sqfeet }
      end

      def sqm_map type = :property
        send("#{type}_sqm_map")
      end

      def room_sqm_map
        [0..100, 6..10, 10..15, 15..20, 20..30, 30..40, 40..100]
      end

      def property_sqm_map
        [0..1000, 12..20, 20..50, 50..100, 100..150, 150..250, 250..1000]
      end

      def property_sqfeet_map
      end

      def cost_map
        [0..40000, 0..3000, 3000..5000, 5000..7000, 7000..10000, 10000..15000, 15000..40000]
      end

      def rooms_map
        [1..10, 1..2, 2..3, 3..4, 4..5, 5..10]
      end

      def rating_map
        [0..5, 1..2, 2..3, 3..4, 4..5]
      end

      def rentability_map
        [0..5, 1..2, 2..3, 3..4, 4]
      end
    end
  end
end