FactoryGirl.define do
  sequence(:furnishment_choice)  { [ [], ['none'], ['partial'], ['full'], ['none', 'partial'], ['full', 'partial'] ].sample }
  sequence(:types_choice)        { [ [], ['apartment', 'room'], ['apartment'], ['apartment', 'house'], ['house', 'villa'] ].sample }

  sequence(:rooms_range)        { [ (1..2), (2..3), (3..4), (4..5)].sample}
  sequence(:cost_range)         { [ (0..2000), (2000..4000), (4000..8000) ].sample }

  sequence(:rating_range)       { [ (0..3), (1..2), (2..4), (3..4) ].sample }
  sequence(:rentability_range)  { [ (0..3), (1..2), (2..3), (1..3) ].sample }

  sequence(:size_range)       { [ (10..30), (20..50), (50..100), (80..150)].sample}
  # period            { Timespan.new(start_date: Date.today, end_date: Date.today + 2.months) }

  factory :range_search, class: 'Property::Search' do
    trait :copenhagen do
      full_address 'Copenhagen'
    end

    trait :valid do
      radius       { FactoryGirl.generate(:radius_choice) }
      rooms        { FactoryGirl.generate(:rooms_range) }
      # furnishment  { FactoryGirl.generate(:furnishment_choice)
      furnishment
      types        { FactoryGirl.generate(:types_choice) }
      size         { FactoryGirl.generate(:size_range) }
      cost         { FactoryGirl.generate(:cost_range) }
      rating       { FactoryGirl.generate(:rating_range) }
      rentability  { FactoryGirl.generate(:rentability_range) }
    end

    factory :valid_range_search, traits: [:valid] 
  end
end