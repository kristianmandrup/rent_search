require 'spec_helper'

describe Property::Searchable do
  def searchable args = {}
    SearchableProperty.create args
  end

  def tomorrow
    @tmrw ||= (Date.today + 1.day)
  end

  context 'default searchable property' do
    subject { searchable }

    its(:valid?)             { should be_true }
    its(:errors)             { should be_empty }
    its('errors.messages')   { should =={} }

    its(:rooms)       { should == 1 }
    its(:type)        { should == 'apartment' }
    its(:furnishment) { should == 'none' }
    its(:cost)        { should == 500 }
    its(:size)        { should == 6 }
    its(:period)      { should be_a Property::Period }
    its('period.dates')  { should be_a Timespan }

    specify do
      Date.parse(subject.period.start_date.to_s).should == Date.today
    end
    
    its(:address)    { should_not be_nil }
    its(:street)     { should be_nil }
  end

  context 'searchable property' do
    subject do 
      prop = searchable rooms: 5, type: 'house', furnishment: 'full', 
                        cost: 1000

      prop.set_address street: street, city: city, country: country 
      prop.country_code = 'DK'     
      prop.period.dates_start = tomorrow
      prop
    end

    let(:street)        { 'Maglekildevej 18' }
    let(:city)          { 'Copenhagen'}
    let(:country)       { 'Denmark'}
    let(:country_code)  { 'DK'}
    
    let(:full) do 
      %w{street city country country_code}.map{|name| send(name) }.join(', ')
    end

    its(:valid?)      { should be_true }
    its(:errors)      { should be_empty }

    its(:rooms)       { should == 5 }
    its(:type)        { should == 'house' }
    its(:furnishment) { should == 'full' }
    its(:cost)        { should == 1000 }    
    its(:size)        { should == 6 }
    its(:period)      { should_not be_nil }
        
    its(:street)          { should == street }
    its(:city)            { should == city }
    its(:country)         { should == country }
    its(:country_code)    { should == 'DK' }    

    specify do
      subject.address.full.should == full
    end

    its('position.to_a')  { should ==  [12.5351893, 55.6755568] }
    its(:latitude)        { should be_within(0.3).of(55.4) }
    its(:longitude)       { should be_within(0.3).of(12.4) }
  end
end