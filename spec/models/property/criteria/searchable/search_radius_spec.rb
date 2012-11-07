require 'spec_helper'

describe Property::Criteria do
  subject { criteria }

  let(:clazz) { Property::Criteria }

  include ::CriteriaSpecHelper

  context 'radius criteria' do
    def adv_hash
      {
        location: 'Copenhagen'
      }
    end

    def adv_search_hash
      {
        radius: 10
      }
    end  

    # search within 10kms of Copenhagen
    let(:criteria)  do
      c = clazz.create adv_search_hash
      puts c.inspect
      c
    end

    describe 'search with near criteria' do
      let(:search_result) { subject.search_near }

      # RANDOM PROPERTIES
      before :each do
        10.times do
          sp = SearchableProperty.create(adv_hash)
          sp.country_code = 'DK'            
        end
        puts SearchableProperty.all #.map(&:inspect)
        Mongoid::Indexing.create_indexes
      end

      specify do
        subject.geo_criteria.should == {:point=>[55.6760968, 12.5683371], :radius=>10, :units=>:km} 
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
  