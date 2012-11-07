require 'spec_helper'

describe Property::Period do
  def period args = {}
    Property::Period.create_it! args
  end

  def tomorrow
    @tmrw ||= (Date.today + 1.day)
  end

  # start_date: Date.today, 
  context 'default searchable property' do
    subject { period duration: 2.days }

    its(:valid?)      { should be_true }
    its(:errors)      { should be_empty }

    its(:dates)      { should be_a Timespan }    

    specify do
      Date.parse(subject.start_date.to_s).should == Date.today
    end
  end
end