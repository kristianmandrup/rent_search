FactoryGirl.define do 
	# inherit ?
	factory :tenant_account, class: 'Tenant::Account' do
		user
		# inbox
		# sentbox
		
		after(:create) do |account, evaluator|	
			FactoryGirl.create :tenant_package, account: account unless account.package
			# account.user = FactoryGirl.create(:user) unless account.user
		end
  end
end


# FactoryGirl.define do 
# 	factory :tenant_account do

# 		after(:create) do |account, evaluator|
# 			unless account.package
# 				package_type = [:free_package, :paid_package].sample
# 				account.package = FactoryGirl.create(package_type) 
# 			end
	  
# 	  	account.user = FactoryGirl.create(:user) unless account.user
# 		end
#   end
# end