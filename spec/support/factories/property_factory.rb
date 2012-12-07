FactoryGirl.define do
	factory :property do

		after(:create) do |property|
			# FactoryGirl.create(:address_da, :addressable => property) # unless property.address && property.address.valid?
			# FactoryGirl.create(:rent_period, :property => property)
		end

		trait :valid do
			sqm
		  rooms
		  cost
		  location 'Copenhagen'
		end	

		factory :valid_property, traits: [:valid]	
	end
end
