class Search
  module Fields
    extend ActiveSupport::Concern

    included do
      shared_concerns  :currency, :size_unit
      include_concerns :sortable

      number_fields.each do |name|
        field name, type: Integer, default: 0  
      end
      
      string_fields.each do |name|
        field name, type: String, default: ''
      end

      validates :radius,       inclusion:  {in: 1..50 }

      validates :size,         inclusion:  {in: 0..6 }
      validates :rooms,        inclusion:  {in: 0..5 }
      validates :cost,         inclusion:  {in: 0..5 }

      validates :rating,       inclusion:  {in: 0..4 }
      validates :rentability,  inclusion:  {in: 0..4 }

      validates :furnishment,  inclusion:  {in: Property::Furnishment.valid_values }
      validates :type,         inclusion:  {in: Property::Type.valid_values }
    end

    module ClassMethods
      def number_fields
        %w{radius rooms size cost rating rentability}
      end

      def string_fields
        %w{location furnishment type currency size_unit}
      end

      def timespan_fields 
        %w{period_from period_to}
      end

      def all_fields
        number_fields + string_fields
      end
    end    
  end
end
