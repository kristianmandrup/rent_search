FactoryGirl.define do
  factory :address do
    sequence(:street)      { Faker::AddressUS.street_address }
    sequence(:city)        { Faker::AddressUS.city }
    sequence(:postal_code) { Faker::AddressUS.zip_code }
    country                'USA'
  end
end