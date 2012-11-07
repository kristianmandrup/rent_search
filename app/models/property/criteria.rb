class Property
  class Criteria
    include BasicDocument

    def self.all_criteria_types
      criteria_type_map.keys
    end

    def self.criteria_types
      criteria_type_map.keys - [:geo]
    end

    def self.criterias
      Property::CriteriaBuilder.criterias
    end

    include_concerns :fields, :setters

    delegate *criterias, to: :builder
    delegate :defaults, :where_criteria, to: :builder
    delegate :distance_unit, to: :defaults

    def builder
      @builder = Property::CriteriaBuilder.new self
    end

    def search 
      puts "Criteria search on: #{clazz}"
       
      basic_search
      # search_near.send(:where, where_criteria)
    end

    def geo_search
      clazz.near(point, radius, units: distance_unit)
    end

    def basic_search
      clazz.where(where_criteria)
    end

    def self.build_from criteria_hash
      self.create mapper(criteria_hash).mapped_hash
    end

    protected

    def clazz
      ::SearchableProperty
    end

    def self.mapper criteria_hash
      Property::Criteria::Mapper.new criteria_hash
    end

    def near_criteria
      [point, radius, units: distance_unit]
    end

    def geo_helper
      @geo_helper ||= GeoHelper.new
    end

    def calc_point address
      geo_helper.calc_point address
    end
  end
end