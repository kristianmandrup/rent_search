FactoryGirl.define do
  factory :address_da, class: 'Address' do
    sequence(:street)      { Faker::AddressDA.street_address }
    sequence(:city)        { Faker::AddressDA.city }
    sequence(:postal_code) { Faker::AddressDA.zip_code }
    country                'Danmark'
    country_code           'DK'
  end
end
