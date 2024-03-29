FactoryGirl.define do
  # Deprecated !?

  factory :search_criteria, class: 'Property::Search::Criteria' do
    trait :random do
      sequence(:rooms)  { [[1,2], [2,3], [2,4], [2,2]].sample}
      price_range       { (3000..6000) }
    end

    trait :copenhagen do
      location 'Copenhagen'
    end
  end
end