require 'spec_helper'

describe Property do
  subject { property }

  def tomorrow
    @tmrw ||= today + 1.day
  end

  def today
    @today ||= Date.today
  end

  def format_date date
    DateTime.parse(date.to_s).strftime('%d %b %Y')
  end

  context 'default' do

    let(:property) { create :valid_property }

    let(:period) { property.period }

    let(:dates)  { period.dates }
    let(:flex)   { period.flex }

    before :all do
      puts "Subject: #{subject}"
    end

    describe 'costs' do
      specify { subject.costs.should be_a Property::Costs }
      specify { subject.entrance_cost.should > 0 }
    end

    describe 'dates' do
      subject { dates }

      specify { dates.asap?.should be_false }
      
      specify { format_date(dates.start_date).should == format_date(today) }
      # specify { format_date(dates.end_date).should == format_date(today + 1.month ) }
    end

    describe 'address' do
      specify { subject.address.country_code.should == 'DK' }
    end
  end
end