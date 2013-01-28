class Property::Search < BaseSearch
  module Fields
    extend ActiveSupport::Concern

    included do
      shared_concerns  :currency, :size_unit      
    end

    # creates the fields for each type supported!
    include_concerns :type_mapping
    include_concerns :setters, :validations    
    include_concerns :sortable    
  end
end
