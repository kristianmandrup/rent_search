FactoryGirl.define do
	factory :tenant_package, class: 'Tenant::Package' do
		sequence(:days_bought) { [20, 40].sample }    
    price   { priced_at(100) }

		after(:create) do |package, evaluator|
      # recursion error!
      # FactoryGirl.create :tenant_account, package: package unless package.account
		end
	end
end