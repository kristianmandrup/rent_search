FactoryGirl.define do
  sequence(:furnishment)  { ['furnished', 'unfurnished'].sample }
  sequence(:published_at) { rand(10).days.ago }
  sequence(:rooms)        { [1,2,2,2,3,3,3,4,4].sample }

  sequence(:type)         { Property::Type.valid_values.sample }
  sequence(:full_type)    { (Property::Type.valid_values - ['room']).sample }

  sequence(:cost)         { 1000 + rand(2) *1000 + rand(5) * 500 }
  sequence(:sqm)          { 50 + rand(5) * 5 }  

  sequence(:parking)      { [true, false].sample }

  sequence(:rentability)  { rand(3) }
  sequence(:rating)       { 1 + rand(5) }

  sequence(:picture)      { rand(7) +1 }
end