FactoryGirl.define do
  sequence(:monthly_rent)         { [1,2,2,2,3,3,4,5].sample * 1000 }
  sequence(:utilities)    { (rand(8) +1) * 100 }
  sequence(:media)        { (rand(8) +1) * 100 }
  sequence(:other)        { rand(2) * 100      }

  factory :monthly_cost, class: 'Property::Costs::MonthlyCost' do
    trait :valid do
      rent
      utilities
      media
      other
    end 

    factory :valid_monthly_cost, traits: [:valid]   
  end

  factory :monthly_costs, class: 'Property::Costs::Monthly', :aliases => [:monthly] do
    trait :valid do
      rent { FactoryGirl.generate :monthly_rent }
      utilities
      media
      other
    end 

    factory :valid_monthly_costs, traits: [:valid]   
  end

  factory :monthly_self_costs, class: 'Property::Costs::MonthlySelf', :aliases => [:monthly_self] do
    trait :valid do
      rent
      utilities
      media
      other
    end 

    factory :valid_monthly_self_costs, traits: [:valid]   
  end
end