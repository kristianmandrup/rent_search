FactoryGirl.define do
  sequence(:date_before)  { rand(10).days.ago }
  sequence(:password)     { 'secret' }
  sequence(:email)        { Faker::Internet.email }
	sequence(:name)         { Faker::Name.name }	  
	sequence(:username)     { Faker::Internet.user_name }
	sequence(:first_name)   { Faker::Name.first_name }
 	sequence(:last_name)    { Faker::Name.last_name }
	sequence(:subject)      { Faker::Lorem.sentence }
  sequence(:title)        { Faker::Lorem.sentence.truncate(30) }
  sequence(:description)  { Faker::Lorem.sentence rand(5)+1 }

  sequence(:date_soon, aliases: [:date]) do
    rand(10).days.from_now
  end

	sequence(:text, aliases: [:body]) do
    Faker::Lorem.paragraph(4)
  end
end
