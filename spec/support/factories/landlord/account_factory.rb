FactoryGirl.define do 
	# inherit ?
	factory :landlord_account, class: 'Landlord::Account' do
		user
		# inbox
		# sentbox

		after(:create) do |account, evaluator|
			# unless account.package
			# 	package_type = [:free_package, :paid_package].sample
			# 	account.package = FactoryGirl.create(package_type) 
			# end

			# account.user = FactoryGirl.create(:user) unless account.user
		end
  end
end
