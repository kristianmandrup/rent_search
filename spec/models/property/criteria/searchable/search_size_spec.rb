require 'spec_helper'
# require 'models/searchable/criteria/helpers/searchable_property'

# Mongoid.logger = Logger.new($stdout)
# Moped.logger   = Logger.new($stdout)

describe Property::Criteria do
  subject { criteria }

  let(:clazz) { Property::Criteria }

  include ::CriteriaSpecHelper

  context 'size criteria' do
    def adv_hash
      {
        size: size    
      }
    end

    def adv_search_hash
      {
        size: 50..100
      }
    end  

    # search within 10kms of Copenhagen
    let(:criteria)  do
      c = clazz.create adv_search_hash
      puts c.inspect
      c
    end

    describe 'search with where criteria' do
      let(:search_result) { subject.search_where }

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
        subject.where_criteria.should == {"address.country_code"=>"DK", "size"=>{"$gte"=> 50, "$lte"=> 100}}
      end

      it 'should have only search results that match criteria' do
        search_result.size.should be_between(1, 10)
        search_result.each do |found|
          found.size.should  be_between(50, 100)
          found.country_code.should == 'DK'
        end
      end
    end
  end  