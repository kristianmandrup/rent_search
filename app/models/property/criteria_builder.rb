class Property
  class CriteriaBuilder
    def self.builders
      (Property::Criteria.criteria_types - [:geo]).map{|type| :"#{type}_builder"}
    end

    def self.criterias
      (Property::Criteria.all_criteria_types).map{|type| :"#{type}_criteria"}
    end

    include_concerns builders, for: 'Property::Criteria::Builder'

    attr_reader :criteria

    def initialize criteria
      @criteria = criteria
    end

    # build where criteria
    def where_criteria
      @where_criteria ||= criteria_types.inject({}) do |res, type|
        criteria_method = "#{type}_criteria"
        sub_criteria = send(criteria_method) if respond_to?(criteria_method)
        res.merge! sub_criteria unless sub_criteria.blank?
        res
      end
    end 

    protected

    def defaults
      @defults ||= Property::Criteria::Fields::Defaults.new
    end

    delegate :criteria_default, :distance_unit, to: :defaults

    def criteria_types
      Property::Criteria.criteria_types
    end    

      
    def period_field
      :dates
    end

    # See: https://github.com/alexreisner/geocoder/issues/87
    def geo_criteria
      {:point => field_value(:point), radius: field_value(:radius), :units => distance_unit}
    end

    def field_value field
      criteria.send(field)
    end

  
  end
end