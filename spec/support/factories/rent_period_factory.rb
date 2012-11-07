FactoryGirl.define do
	sequence(:rent) 				{ priced_at(2300) }
	sequence(:deposit) 			{ priced_at(6900)  }
	sequence(:prepaid_rent) { priced_at(4600)  }
	sequence(:utility_cost) { priced_at(1200)  }

	sequence(:period) 			{ [30, 90, 180].sample.days  }

	sequence(:publish_at) { 10.days.from_now }

	factory :rent_period do
		rent
	 	deposit			  
	 	prepaid_rent
	 	utility_cost

		period

	  publish_at
	  property

	  after(:create) do |rent_period, evaluator|	  	
	  end
	end
end
