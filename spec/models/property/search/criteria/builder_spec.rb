require 'spec_helper'

describe Property::Search::Criteria::Builder do
  subject { builder }

  let(:builder) { Property::Search::Criteria::Builder.new search }

  let(:search) { create(:valid_property_search) }

  describe '#where_criteria' do
    specify do
      subject.where_criteria.should be_a Hash
    end

    specify do
      subject.where_criteria.should_not be_empty
    end
  end

  describe '#builder_for' do
    [:string, :number, :boolean].each do |type|
      specify do
        subject.builder_for(type).should be_a Property::Search::Criteria::Builder::Base
      end
    end

    # list {"types"=>{"$in"=>["apartment"]}, "rooms"=>{"$in"=>[2, 3]}}
    [:list, :range, :timespan].each do |type|
      specify do
        clazz_name = "Property::Search::Criteria::Builder::#{type.to_s.camelize}Criteria"

        subject.builder_for(type).should be_a clazz_name.constantize
      end
    end
  end

  describe 'initialize search' do    
    specify { subject.search.should == search }
  end

  describe 'protected' do

    describe 'type_builders' do
      specify do
        subject.type_builders.should_not be_empty
        subject.type_builders.should_not include(:geo)
      end
    end

    describe 'make_builder type' do
      specify do
        subject.make_builder(:range).should be_a Property::Search::Criteria::Builder::RangeCriteria
      end

      specify do
        subject.make_builder(:range).search.should == search
      end

      specify do
        subject.make_builder(:range).criteria_type.should == 'range'
      end
    end

    describe 'builder_class_for type' do
      specify do
        subject.builder_class_for(:range).should be_a Class
      end
    end

    describe 'builder_class_name_for type' do
      specify do
        subject.builder_class_name_for(:range).should match /RangeCriteria$/
      end
    end

    describe 'empty_builder' do
      specify do
        subject.empty_builder.build.should == {}
      end
    end

    describe 'base_builder type' do
      specify do
        subject.base_builder(:string).should be_a Property::Search::Criteria::Builder::Base
      end

      specify do
        subject.base_builder(:string).search.should == search
      end
    end

    describe 'type_builder? type' do
      specify do
        subject.type_builder?(:string).should be_true
      end

      specify do
        subject.type_builder?(:list).should be_true
      end

      specify do
        subject.builder_for?(:unknown).should be_false
      end            
    end      

    describe 'builder_for? type' do
      specify do
        subject.builder_for?(:string).should be_false
      end

      specify do
        subject.builder_for?(:list).should be_true
      end      

      specify do
        subject.builder_for?(:unknown).should be_false
      end      
    end
  end
end