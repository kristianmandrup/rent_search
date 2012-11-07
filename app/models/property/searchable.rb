require 'timespan/mongoid'

class Property
  module Searchable
    extend ActiveSupport::Concern
    include BasicDoc
    include Mongoid::Timespanned

    included do
      include_concerns :living_space, :location, :rent_cost, :rent_period, for: 'Property'
      include_concerns :description, :rentability, :ratable, :publish,     for: 'Property'
      include_concerns :picture_gallery, for: 'Property'
    end

    def short_location
      "#{region_desc}, #{city}, #{country_code}" 
    end

    def rent_desc
      "#{total_rent} DKK"
    end    

    def total_rent= rent
      configure_searchable
      costs.monthly.rent = rent
    end
    alias_method :cost=, :total_rent=

    def lines *numbers
      numbers = numbers.flatten
      numbers = numbers.first.kind_of?(Range) ? numbers.first.to_a : numbers
      numbers.map {|n| send("line_#{n}") }
    end

    protected

    def region_desc
      region.sub(/ Region of Denmark$/, '')
    end

    def display_size unit = :m2
      unit == :m2 ? "#{sqm} m2" : "#{sqfeet} ft"      
    end

    def display_rooms
      "#{bedrooms}/#{rooms}"
    end

    def line_1
      "#{display_size} #{type} on #{floor_adr}"
    end

    def line_2
      "#{display_rooms} #{furnishment} rooms"
    end  

    def line_3
      short_location
    end

    def line_4
      period.short_desc
    end

    def configure_searchable
      unless self.period
        self.period = Property::Period.create_default!
      end

      unless self.costs
        self.costs = Property::Costs.new
      end

      unless self.costs.monthly
        self.costs.monthly = Property::Costs::Monthly.new
      end

      unless self.address
        self.address = Address.new
      end
    end    
  end
end