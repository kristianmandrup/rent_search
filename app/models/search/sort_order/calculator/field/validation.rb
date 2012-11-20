module Search::SortOrder::Calculator::Field
  module Validation
    extend ActiveSupport::Concern

    def valid_field? field_name
      return false if field_name.blank?
      return true if allow_any_field?
      sort_fields.include? field_name.to_s
    end

    delegate :sort_fields, :allow_any_field?, to: :sort_order    
  end
end
