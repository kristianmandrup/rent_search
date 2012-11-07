class Property::Search
  module Sortable
    extend ActiveSupport::Concern

    included do
      include_concern :sortable, from: 'Search'
    end

    module ClassMethods
      def ascenders
        %w{date cost cost_sqm size rooms}
      end

      def descenders
        %w{rating cost cost_sqm size rooms}
      end
    end    
  end
end
