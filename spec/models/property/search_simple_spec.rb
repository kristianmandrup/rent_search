require 'spec_helper'

describe Property::Criteria do

  let(:clazz) { Property::Criteria }

  def date millis
    time = millis.kind_of?(Fixnum) ? DateTime.parse(Time.at(millis).to_s) : millis
    time.strftime('%d %b %Y')
  end

  describe 'class methods' do
    subject { clazz }

    its(:search_fields) { should include('type') }
  end

  subject { criteria }

  include ::CriteriaSpecHelper

  describe 'default field values' do
    let(:criteria)  do
      clazz.create
    end

    Property::Criteria.search_fields.each do |field|
      its(field) { should == default(field) }
    end
  end

  describe 'string_criteria' do
    let(:criteria)  do
      clazz.create type:         'apartment', furnishment:  'furnished',
                   full_address: 'Copenhagen', country_code: 'SE' # do not allow SE for now
    end

    specify do
      subject.send(:string_criteria).should == {"type"=>"apartment", "furnishment"=>"furnished", "address.country_code"=>"SE"}
    end
  end

  describe 'range_criteria' do
    let(:criteria)  do
      clazz.create total_rent: 1000..3000, size: 10..40, rooms: 1..2
    end

    specify do
      subject.send(:range_criteria).should == {"costs.monthly.total"=>{"$gte"=>1000, "$lte"=>3000}, "size"=>{"$gte"=>10, "$lte"=>40}, "rooms"=>{"$gte"=>1, "$lte"=>2}}
    end
  end

  describe 'boolean_criteria' do
    let(:criteria)  do
      clazz.create shared: true
    end

    specify do
      subject.send(:boolean_criteria).should == {"shared"=> true}
    end
  end

  describe 'list_criteria' do
    pending 'No list criterias yet'
  end

  describe 'number_criteria' do
    pending 'No number criterias yet'
  end

  describe 'geomap_criteria' do
    let(:criteria)  do
      clazz.create radius: 20
    end

    specify do
      # longitude, latitude
      subject.send(:geo_criteria).should == {:point=> [latitude, longitude], :radius=>20, :units=>:km}
    end
  end

  describe 'timespan_criteria' do
    let(:criteria)  do
      # TODO: Fix timespan error with start_date, duration combination!
      clazz.create period: Timespan.new(start_date: Date.today, end_date: Date.today + 2.months)
    end

    let(:timespan) { subject.send(:timespan_criteria) }

    let(:min_time) do
      date timespan["period.dates.from"]["$gte"]      
    end

    let(:max_time) do
      date timespan["period.dates.to"]["$lte"]
    end

    specify do
      min_time.should == date(Date.today)
      max_time.should == date(Date.today + 2.months)
    end
  end
end
