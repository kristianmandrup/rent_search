# encoding: UTF-8

class SearchableProperty
  include BasicDocument

  include_concerns :searchable, :rateable, for: 'Property'

  field :parking,         type: Boolean, default: false
  field :washing_machine, type: Boolean, default: false

  acts_as_url :title, sync_url: true

  # paginates_per 50

  # spatial_index :position
  # spatial_scope :position

  def info type = :short
    case type
    when :short
      "#{rooms_desc}, #{sqm} m&sup2;".safe_html
    else
      "unknown info: #{type}"
    end
  end

  def floor_adr
    read_attribute(:floor_adr) || 'ground'
  end

  def size_desc
    sqm ? sqm_desc : sqfeet_desc
  end

  def sqm_desc
    "#{sqm} m&sup2;"
  end

  def sqfeet_desc
    "#{sqm} ft&sup2;"
  end

  def rooms_desc
    rooms == 1 ? "#{rooms} room" : "#{rooms} rooms"
  end

  def bedrooms_desc
    bedrooms == 1 ? "#{bedrooms} bedroom" : "#{bedrooms} rooms"
  end

  def furnished_desc
    furnished? ? "furnished" : "unfurnished"
  end

  # using Stringex gem - https://github.com/rsl/stringex
  def to_param
    url # or whatever you set :url_attribute to
  end

  def to_s
    %Q{
#{self.class}
#{id}
#{url}
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