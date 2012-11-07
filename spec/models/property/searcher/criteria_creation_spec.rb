require 'spec_helper'

describe Property::Searcher do
  let(:clazz) { Property::Searcher }

  include ::CriteriaSpecHelper

  let(:default_criteria)  do
    c = clazz.new
    puts c.inspect
    c
  end

  let(:rent_criteria)  do
    c = clazz.new total_rent: '1'
    puts c.inspect
    c
  end

  context 'default criteria' do
    subject { default_criteria }

    specify do
      subject.criteria.where_criteria.should == {"address.country_code"=>"DK"}
    end      
  end

  context 'cost criteria' do
    subject { rent_criteria }

    specify do
      subject.criteria.where_criteria.should == {"address.country_code"=>"DK", "costs.monthly.total_rent"=>{"$gte"=>0, "$lte"=>3000}}
    end
  end  
end