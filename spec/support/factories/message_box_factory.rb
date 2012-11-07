FactoryGirl.define do
  factory :message_box do
  	name
	  description

    ignore do
      message_count 0
    end

    after(:build) do |message_box, evaluator|
      if evaluator.message_count > 0
        FactoryGirl.create_list(:message, evaluator.message_count, message_box: message_box)
      end
    end

    factory :inbox, class: 'MessageBox' do
      name 'inbox'
    end

    factory :sentbox, class: 'MessageBox' do
      name 'sentbox'
    end

  	factory :message_box_with_messages do
	  end
  end
end
