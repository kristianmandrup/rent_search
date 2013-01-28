FactoryGirl.define do
  factory :searchable_property, class: 'SearchableProperty' do

    after(:build) do |property|
      # property.period = Property::Period.create_it! start_date: Date.today, duration: (rand(5) +1).months      
      FactoryGirl.create :rent_period, property: property unless property.period

      # puts "doing the fucking shit!"

      # property.picture = 'fuck you bastard'

      if property.type == 'room'
        property.rooms = 1
        property.sqm = 6 + rand(5) * 5 # 6 - 26
        property.cost = 1000 + 1000 * rand(3)
      end

      property.bedrooms = case property.rooms
      when 1..3
        rand(property.rooms) + 1
      when 4..6
        rand(property.rooms-1) +1
      else
        rand(property.rooms-2) +1
      end

      property.bathrooms = case property.rooms
      when 1..3
        1
      when 3..6
        rand(2) +1
      else
        rand(3) +1
      end      
    end

    trait :valid do
      picture
      title
      description      
      
      location 'Copenhagen'
      furnishment
      rooms
      type
      sqm
      cost
      parking
      published_at
      rating
      rentability
    end 

    trait :room do
      # location 'Copenhagen' # TODO
      furnishment
      rooms    1
      type     'room'
      sqm     { FactoryGirl.generate :room_size }
      cost
    end 

    trait :full do
      # location 'Copenhagen' # TODO
      furnishment
      rooms
      type     { FactoryGirl.generate :full_type }
      sqm
      cost
    end 

    factory :valid_searchable_room, traits: [:valid, :room] 
    factory :valid_searchable_full_property, traits: [:valid, :full] 
    factory :valid_searchable_property, traits: [:valid] 
  end
end
