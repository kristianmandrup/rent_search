FactoryGirl.define do
  factory :costs, class: 'Property::Costs' do  
    trait :valid do
      after :build do |costs|
        FactoryGirl.create :valid_monthly_costs, costs: costs
        FactoryGirl.create :valid_one_time_costs, costs: costs
      end
    end 

    factory :valid_costs, traits: [:valid] 
  end

  factory :costs_self, class: 'Property::CostsSelf' do  
    trait :valid do
      after :build do |costs|
        FactoryGirl.create :valid_monthly_costs, costs: costs
        FactoryGirl.create :valid_one_time_costs, costs: costs
      end
    end 

    factory :valid_costs_self, traits: [:valid]     
  end
end