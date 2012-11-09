class Search::Sorter

  # Can retrive the valid list of fields for each direction

  # Usage: Use in the main Sorter for your model,fx Property::Sorter
  module Fields
    extend ActiveSupport::Concern

    # requires :asc_fields and :desc_field methods
    def fields dir = :asc
      return all_fields if dir == :both
      send("#{dir}_fields")
    end

    def all_fields
      @all_fields ||= fields(:asc) & fields(:desc)
    end
  end
end