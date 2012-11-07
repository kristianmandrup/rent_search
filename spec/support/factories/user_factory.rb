FactoryGirl.define do
  factory :user do
    name
    email
    username
    password   

    ignore do
      type 'none'
    end

  	after(:create) do |user, evaluator|
      FactoryGirl.create(:address, addressable: user) unless user.address

  		# return if user.tenant_account || user.landlord_account

      case evaluator.type
      when :both, :landlord
        FactoryGirl.create(:landlord_account, user: user)
      when :both, :tenant
        FactoryGirl.create(:tenant_account, user: user)
      end
  	end

    factory :tenant_user do
      after(:create) do |user, evaluator|
        FactoryGirl.create :tenant_account, user: user
      end
    end

    factory :landlord_user do
      after(:create) do |user, evaluator|
        FactoryGirl.create :landlord_account, user: user
      end
    end

    factory :both_user do
      after(:create) do |user, evaluator|
        FactoryGirl.create :landlord_account, user: user
        FactoryGirl.create :tenant_account, user: user
      end
    end
  end
end