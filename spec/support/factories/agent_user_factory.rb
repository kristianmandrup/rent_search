FactoryGirl.define do
  factory :agent_user do
    name
    
    trait :non_empty do
      after(:build) do |user|
        FactoryGirl.create :agent, user: user
      end
    end   
  end
end