module SearchSetup
  extend ActiveSupport::Concern

  included do
    subject { results }

    let(:results)        { search_criteria.search }
    let(:addresses)      { MainApp.config.addresses :da }
    let(:property_count) { 10 } # override

    before do 
      property_count.times do |n|
        hash = addresses[n].symbolize_keys.merge(rooms: rooms, price: price, title: 'new prop')
        Property.create hash
        property.active_rental_period = RentPeriod.new period: timespan
      end
    end    
  end

  def timespan
    Timespan.new from: rand(5).days.ago, to: rand(15).days.from_now
  end

  def rooms
    [1,2,2,3,3,4].sample
  end

  def price
    [2600,3200,3600,3900,4500,4800,6000,7500].sample
  end

  def property_hash
    {title: 'a nice property' }
  end
end

module CriteriaSpecHelper
  def default name
    clazz.criteria_default name
  end

  def base_pos
    [longitude, latitude]
  end

  def latitude
    55.6760968
  end

  def longitude
    12.5683371
  end

  def property_type
    'apartment'
  end

  def adv_search_hash
    {
      # radius: 10, 
      type: 'apartment', 
      rooms: 2..3,
      size: 50..100,
      total_rent: 2000..6000,
      period: search_period,
      full_address: 'Copenhagen'
    }
  end

  def format_date date
    DateTime.parse(date.to_s).strftime('%d %b %Y')
  end  

  def from; Date.today.to_time.to_i; end
  def untill; from + 1.month; end

  def search_period
    ::Timespan.new(start_date: Date.today, duration: 1.month)
  end

  def search_hash
    {
      type: 'apartment'
    } 
  end

  def prop_hash
    {type: 'apartment'}
  end

  def rooms
    rand(3)+2
  end

  def size
    rand(80)+40
  end

  def position
    random_point_within(10.kms)
  end

  def period
    Timespan.new(start_date: Date.today, duration: (rand(6)+2).weeks)   
  end

  def cost
    [2600,3200,3600,3900,4500,4800,6000,7500].sample
  end  
  alias_method :total_rent, :cost

  def random_point_within distance
    radians = Geocoder::Calculations.distance_to_radians(distance.number, distance.unit)
    # puts "radians: #{radians} for #{distance}"
    Circle.random_point(base_pos, radians)
  end

  def random_vector distance
    [distance, 0].vector.random_vector
  end  
end