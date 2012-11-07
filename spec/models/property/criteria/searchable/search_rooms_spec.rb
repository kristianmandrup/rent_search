require 'spec_helper'
# require 'models/searchable/criteria/helpers/searchable_property'

# Mongoid.logger = Logger.new($stdout)
# Moped.logger   = Logger.new($stdout)

describe Property::Criteria do
  subject { criteria }

  let(:clazz) { Property::Criteria }

  include ::CriteriaSpecHelper

  context 'rooms criteria' do
    def adv_hash
      {
        rooms: rooms    
      }
    end

    def adv_search_hash
      {
        rooms: 2..3
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
        subject.where_criteria.should == {"address.country_code"=>"DK", "rooms"=>{"$gte"=>2, "$lte"=>3}}
      end

      it 'should have only search results that match criteria' do
        search_result.size.should be_between(1, 10)

        search_result.each do |found|
          found.rooms.should        be_between(2, 3)
          found.country_code.should == 'DK'
        end
        puts "RESULTS found: #{search_result.size}"
      end
    end
  end
end