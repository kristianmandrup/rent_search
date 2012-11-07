FactoryGirl.define do
  factory :agent do

    trait :non_empty do
      after(:build) do |agent|
        FactoryGirl.create :valid_search, agent: agent
      end    
    end
  end
end