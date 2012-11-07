class Property::Search
  module Fields
    extend ActiveSupport::Concern

    included do
      shared_concerns  :currency, :size_unit
      include_concerns :sortable, :validations, :type_mapping
    end
  end
end
