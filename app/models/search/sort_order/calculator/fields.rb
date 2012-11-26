class Search::SortOrder::Calculator

  # Can retrive the valid list of fields for each direction

  # Usage: Use in the main Sorter for your model,fx Property::Sorter
  module Fields
    extend ActiveSupport::Concern

    # requires :asc_fields and :desc_field methods
    def fields dir = :asc
      return sort_fields if dir == :both
      send("#{dir}_fields")
    end

    def sort_fields
      @sort_fields ||= (fields(:asc) | fields(:desc)).map(&:to_sym)
    end
  end
end