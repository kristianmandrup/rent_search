FactoryGirl.define do
	factory :landlord_package, class: 'Landlord::Package' do
		sequence(:days_bought) { [30, 90].sample }
    price   { priced_at(100) }

		after(:create) do |package|
      # recursion error!
      # FactoryGirl.create :landlord_account, package: package unless package.account
		end
	end
end