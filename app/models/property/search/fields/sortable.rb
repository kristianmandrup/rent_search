class Property::Search < BaseSearch
  module Fields
    module Sortable
      extend ActiveSupport::Concern

      included do
        include_concern :sortable, for: 'BaseSearch'
      end

      module ClassMethods
        def asc_fields
          %w{date cost cost_sqm size rooms}
        end

        def desc_fields
          %w{rating cost cost_sqm size rooms}
        end
      end    
    end
  end
end