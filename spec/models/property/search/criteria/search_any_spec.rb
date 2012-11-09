require 'spec_helper'

describe Property::Criteria do
  subject { criteria }

  let(:clazz) { Property::Criteria }

  include ::CriteriaSpecHelper

  context 'any criteria' do
    let(:criteria)  do
      c = clazz.create
      puts c.inspect
      c
    end

    describe 'search with where criteria' do
      # let(:search_result) { subject.search_where }
      let(:search_result) { subject.search }

      # RANDOM PROPERTIES
      before :each do
        10.times do
          create :valid_property
        end
        puts Property.all #.map(&:inspect)
        Mongoid::Indexing.create_indexes
      end

      specify do
        subject.where_criteria.should == {"address.country_code"=>"DK"}
      end

      it 'should have only search results that match criteria' do
        search_result.size.should be_between(1, 10)
        search_result.each do |found|
          found.country_code.should == 'DK'
        end

        puts "RESULTS found: #{search_result.size}"
      end
    end
  end    
end  