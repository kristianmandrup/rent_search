require 'spec_helper'

describe Property::Search::Criteria::Builder::ListCriteria do
  subject { builder }

  let(:builder) { Property::Search::Criteria::Builder::ListCriteria.new search }

  let(:search) { create(:valid_property_search) }


  describe 'criteria_for value' do
    specify do
      subject.criteria_for([1,2]).should == {'$in' => [1,2]}
    end
  end
end