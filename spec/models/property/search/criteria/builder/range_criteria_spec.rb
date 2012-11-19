require 'spec_helper'

describe Property::Search::Criteria::Builder::RangeCriteria do
  subject { builder }

  let(:builder) { Property::Search::Criteria::Builder::RangeCriteria.new search }

  let(:search) { create(:valid_property_search) }


  describe 'criteria_for value' do
    specify do
      subject.criteria_for(100..500).should == {"$gte"=>100, "$lte"=>500} 
    end
  end
end