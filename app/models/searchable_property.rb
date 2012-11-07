# encoding: UTF-8

class SearchableProperty
  include BasicDocument

  include_concerns :searchable, for: 'Property'

  field :parking,         type: Boolean, default: false
  field :washing_machine, type: Boolean, default: false

  # paginates_per 50

  # spatial_index :position
  # spatial_scope :position

  def to_s
    %Q{
#{self.class}
#{id}
created:      #{created_at}
published:    #{published_at}

title:        #{title}
desc:         #{description}

shared:       #{shared if self.respond_to? :shared}
type:         #{type}

Rooms
rooms:        #{rooms}
bedrooms:     #{bedrooms}
bathrooms:    #{bathrooms}

Size:      
- m2:         #{sqm}
- ft2:        #{sqfeet}

Costs:        
#{costs}
cost:         #{cost}

€/m2:         #{cost_sqm}
€/ft2:        #{cost_sqfeet}

rating:       #{rating}
rentability   #{rentability_level}

furnishment:  #{furnishment}

parking:      #{parking}
w.machine:    #{washing_machine}

period:       #{period.dates if period}

position:     #{position.to_a}

address:
#{address}
}


  end
end