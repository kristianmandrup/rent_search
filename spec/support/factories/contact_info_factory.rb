FactoryGirl.define do
  factory :contact_info do
    ignore do
      number '555-8484'
    end

    after :create do |contact_info, evaluator|
      if evaluator.number
        contact_info.phone_numbers ||= []
        contact_info.phone_numbers << PhoneNumber.create(number: number)
      end
    end
  end
end