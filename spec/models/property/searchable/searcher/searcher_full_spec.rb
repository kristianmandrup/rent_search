require 'spec_helper'

Mongoid.logger = Logger.new($stdout)
Moped.logger   = Logger.new($stdout)

describe Property::Searcher do
  subject { searcher }

  let(:clazz) { Property::Searcher }

  include ::CriteriaSpecHelper

  def adv_search_hash
    {
      radius: 10, 
      type: 'apartment', 
      rooms: 2,
      size: 'any',
      cost: 3,
      # period: search_period,
      location: 'Copenhagen'
    }
  end

  def search_hash
    {"search"=>{"radius"=>"any", "location"=>"", "furnish"=>"any", "rooms"=>"any", "type"=>"property", "size"=>"any", "cost"=>"1", "period_from"=>"", "period_to"=>""}}
  end

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
    let(:searcher) do
      s = clazz.new adv_search_hash
      puts "SEARCHER: #{s.inspect}"
      s
    end

    describe 'where_criteria' do

      # RANDOM PROPERTIES
      before :each do
        5.times do
          sp = SearchableProperty.create(adv_hash)
          sp.country_code = 'DK'
        end
        # puts SearchableProperty.all.map(&:inspect)
        Mongoid::Indexing.create_indexes
      end

      specify do
        searcher.criteria_hash.should == {:radius=>10, :type=>"apartment", :rooms=>2, :size=>"any", :cost=>3, :location=>"Copenhagen"}
      end

      specify do
        subject.where_criteria.should == {"type"=>"apartment", "address.country_code"=>"DK", "cost"=>{"$gte"=>2000, "$lte"=>6000}, "size"=>{"$gte"=>50, "$lte"=>100}, "rooms"=>{"$gte"=>2, "$lte"=>3} }
      end

      specify do
        results.size.should == 4
      end      
    end
  end
end