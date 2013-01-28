class Property::Search < BaseSearch
  module Fields
    class Defaults
      def criteria_default name
        criteria_defaults_map[name.to_sym]
      end

      def distance_unit
        :km
      end

      protected

      def geo_helper
        @geo_helper ||= Property::Search::GeoHelper.new
      end    

      def default_point
        geo_helper.calc_point 'Copenhagen'
      end

      def default_address
        'Copenhagen'
      end

      def default_period
        ::Timespan.new default_timespan
      end

      def default_timespan
        {start_date: default_start_date, end_date: default_end_date}
      end

      def default_start_date
        Date.today - 2.weeks
      end

      def default_end_date
        Date.today + 2.years
      end

      # TODO: load values from YML file
      def criteria_defaults_map
        {
          country_code:   'DK',
          shared:         nil,
          type:           'any',
          furnishment:    'any',
          full_address:   default_address,
          rooms:          1..10,
          radius:         50,
          cost:           0..40000,  
          rating:         0..5,
          rentability:    0..3,
          sqm:            default_sqm,
          sqfeet:         default_sqm.to_sqfeet,
          period:         default_period,
          point:          default_point
        }
      end

      def default_sqm
        0..1000
      end
    end
  end
end