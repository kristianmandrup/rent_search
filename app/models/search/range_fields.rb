class Search
  module RangeFields
    extend ActiveSupport::Concern

    included do
      shared_concerns   :currency, :size_unit
      include_concerns  :sortable

      number_fields.each do |name|
        field name, type: Integer, default: 2
      end

      range_fields.each do |name|
        field name, type: Range 
      end
      
      string_fields.each do |name|
        field name, type: String, default: ''
      end

      arr_fields.each do |name|
        field name, type: Array, default: []
      end

      timespan_fields.each do |name|
        field name, type: Timespan
      end

      validates :radius,       inclusion:  {in: 1..50 }

      validates :rooms,        range:  {within: 1..10 }
      validates :size,         range:  {within: 5..1000 }
      validates :cost,         range:  {within: 0..40000 }
      validates :rating,       range:  {within: 0..5 }
      validates :rentability,  range:  {within: 0..3 }

      # if using: none, partial, full
      # validates :furnishment,  array:  {in: Property::Furnishment.valid_values }

      validates :furnishment,  inclusion:  {in: Property::Furnishment.valid_values }
      validates :types,        array:      {in: Property::Type.valid_values }
    end

    module ClassMethods
      def number_fields 
        %w{radius}
      end

      def range_fields
        %w{rooms size cost rating rentability}
      end

      def arr_fields
        %w{types}
      end

      def timespan_fields
        %w{period_from period_to}
      end      

      def string_fields
        %w{location furnishment currency size_unit}
      end

      def all_fields
        number_fields + range_fields + arr_fields + string_fields + timespan_fields
      end
    end    
  end
end
