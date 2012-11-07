FactoryGirl.define do
	factory :message, class: 'Mail::Message' do
	  subject
	  body	  
	end
end