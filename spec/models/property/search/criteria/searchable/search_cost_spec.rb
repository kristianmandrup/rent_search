require 'spec_helper'

describe Property::Criteria do
  subject { criteria }

  let(:clazz) { Property::Criteria }

  include ::CriteriaSpecHelper

  context 'cost criteria' do
    def adv_hash
      {
        total_rent: cost
      }
    end

    def adv_search_hash
      {
        total_rent: 1000..5000
      }
    end  

    # search within 10kms of Copenhagen
    let(:criteria)  do
      c = clazz.create adv_search_hash
      puts c.inspect
      c
    end

    describe 'search with where criteria' do
      # let(:search_result) { subject.search_where }
      let(:search_result) { subject.search }

      def create_searchable
        sp = SearchableProperty.create(adv_hash)
        # sp.period.dates = period
        sp.country_code = 'DK'                      
      end        

      def create_property
        create :valid_property
      end

      # RANDOM PROPERTIES
      before :each do
        10.times do
          create_property
        end
        puts Property.all #.map(&:inspect)
        
        # Mongoid::Indexing.create_indexes
      end

      specify do
        subject.where_criteria.should == {"address.country_code"=>"DK", "costs.monthly.total_rent"=>{"$gte"=> 1000, "$lte"=> 5000}}
      end

      it 'should have only search results that match criteria' do
        search_result.size.should be_between(1, 10)
        search_result.each do |found|
          found.total_rent.should be_between(1000, 5000)
          found.country_code.should == 'DK'
        end

        puts "RESULTS found: #{search_result.size}"
      end
    end
  end    
end  