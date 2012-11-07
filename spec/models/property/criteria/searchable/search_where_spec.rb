require 'spec_helper'
# require 'models/searchable/criteria/helpers/searchable_property'

# Mongoid.logger = Logger.new($stdout)
# Moped.logger   = Logger.new($stdout)

describe Property::Criteria do
  subject { criteria }

  let(:clazz) { Property::Criteria }

  include ::CriteriaSpecHelper

  def adv_hash
    {
      rooms: rooms, 
      size: size,
      cost: cost, 
      position: position,
      shared: true
    }
  end

  context 'full criteria' do
    # search within 10kms of Copenhagen
    let(:criteria)  do
      c = clazz.create adv_search_hash
      puts c.inspect
      c
    end

    describe 'where_criteria' do

      # RANDOM PROPERTIES
      before :each do
        5.times do
          sp = SearchableProperty.create(adv_hash)
          sp.country_code = 'DK'
          sp.period.dates = period
        end
        # SearchableProperty.all
      end

      specify do
        subject.where_criteria.should == {"type"=>"apartment", 
          "address.country_code"=>"DK", "radius"=>10, 
          "costs.monthly.total_rent"=>{"$gte"=>2000, "$lte"=>6000}, 
          "size"=>{"$gte"=>50, "$lte"=>100}, "rooms"=>{"$gte"=>2, "$lte"=>3}, 
          "period.dates.from"=>{"$gte"=> from }, 
          "period.dates.to"=>{"$lte"=> untill}}
      end
    end

    describe 'search with where criteria' do
      let(:search_result) { subject.search_where }

      # RANDOM PROPERTIES
      before :each do
        10.times do
          sp = SearchableProperty.create(adv_hash)
          sp.country_code = 'DK'            
        end
        puts SearchableProperty.all
        Mongoid::Indexing.create_indexes
      end

      it 'should have only search results that match criteria' do
        search_result.size.should be_between(1, 10)

        search_result.each do |found|
          found.type.should         == 'apartment'
          found.cost.should         be_between(2000, 6000)
          found.rooms.should        be_between(2, 3)
          found.size.should         be_between(50, 100)
          found.shared.should       == true
          found.country_code.should == 'DK'
        end
        puts "RESULTS found: #{search_result.size}"
      end
    end
  end
end
  