class Property::Search < BaseSearch
  module Fields
    module TypeMapping
      extend ActiveSupport::Concern
    
      included do
        field_types.each do |type, clazz|
          fields_for(type).each do |name|
            field name, type: clazz, default: default_value(name)
          end
        end

        # for geo helper, used in calculating point
        include_concern :geo, for: 'Property::Search'      
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
            string:     %w{furnishment full_address country_code currency size_unit type},
            boolean:    %w{shared},
            number:     %w{radius},
            list:       %w{types rooms},
            # cost_sqm cost_sqfeet ??
            range:      %w{cost sqm sqfeet rentability rating},
            timespan:   %w{period},
            geo:        %w{point},
          }
        end

        def field_type_of field
          reverted_type_names[field.to_s]
        end

        def reverted_type_names
          @reverted_type_names ||= type_names.revert
        end

        def criteria_types
          type_names.keys
        end

        def field_names
          type_names.values.flatten
        end  
        alias_method :search_fields, :field_names
        alias_method :all_fields, :field_names
      end
    end
  end
end