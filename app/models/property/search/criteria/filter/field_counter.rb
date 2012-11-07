class Property::Criteria::Filter
  class FieldCounter
    attr_reader :search

    def initialize search
      @search = search
    end

    def field_selector
      @field_selector ||= Property::Criteria::Filter::FieldSelector.new search.to_a
    end

    delegate :values_for, :selected_fields, to: :field_selector
  end
end