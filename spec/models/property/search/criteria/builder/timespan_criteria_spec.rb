require 'spec_helper'

describe Property::Search::Criteria::Builder::TimespanCriteria do
  subject { builder }

  let(:builder) { Property::Search::Criteria::Builder::TimespanCriteria.new search }

  let(:search) { create(:valid_property_search) }

  let(:timespan) do
    Timespan.new start_time: 1.day.ago
  end

  describe 'creator(field, value)' do
    specify do
      subject.send(:creator, 'timespan', timespan).should be_a Property::Search::Criteria::Builder::TimespanCriteria::Creator
    end
  end

  describe 'set_criteria(criteria_hash, field, value)' do
    specify do
      subject.set_criteria({}, :timespan, timespan).should == {"timespan.period.from"=>{"$gte"=> timespan.start_time.to_i}, "timespan.period.to"=>{"$lte"=> timespan.end_time.to_i}} 
    end
  end
end