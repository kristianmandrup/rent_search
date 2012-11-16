module Search::SortOrder::Calculator::Field
  module Validation
    extend ActiveSupport::Concern

    def valid_field? field_name
      return false if field_name.blank?
      sort_fields.include? field_name.to_s
    end

    delegate :sort_fields, to: :sort_order    
  end
end
