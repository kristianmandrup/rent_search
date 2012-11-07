module Property::Search::Fields
  module TypeMapping
    extend ActiveSupport::Concern
  
    included do
      field_types.each do |type, clazz|
        fields_for(type).each do |name|
          field name, type: clazz, default: default_value(name)
        end
      end
    end

    module ClassMethods
      def default_value name
        defaults ? defaults.value_for(name) : nil        
      end

      def defaults
        nil
        # @defaults ||= Property::Search::Fields::Defaults.new
      end

      def fields_for type
        raise ArgumentError, "Type #{type} not supported for #{self.class}" unless type_names[type.to_sym]
        type_names[type.to_sym]
      end

      def field_types
        {
          boolean:  Boolean,
          string:   String,
          number:   Integer,
          range:    Range,
          list:     Array,
          timespan: Timespan,
          geo:      Array # Mongoid::Geospatial::Point ?
        }
      end

      def type_names
        {
          string:     %w{furnishment full_address country_code currency size_unit},
          boolean:    %w{shared},
          number:     %w{radius},
          list:       %w{types}
          range:      %w{total_rent sqm sqfeet rentability rating rooms},
          timespan:   %w{period},
          geo:        %w{point},
        }
      end

      def all_field_names
        type_names.values
      end  
    end
  end
end