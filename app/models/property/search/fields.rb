class Property::Search
  module Fields
    extend ActiveSupport::Concern

    included do
      shared_concerns  :currency, :size_unit
      include_concerns :sortable, for: 'Property::Search'
    end
  end
end
