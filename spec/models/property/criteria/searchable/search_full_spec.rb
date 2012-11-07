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
      total_rent: cost, 
      position: position,
      # shared: true
    }
  end

  context 'full criteria' do
    # search within 10kms of Copenhagen
    let(:criteria)  do
      c = clazz.create adv_search_hash
      puts c.inspect
      c
    end

    describe 'search with full criteria' do
      let(:search_result) { subject.search }

      # RANDOM PROPERTIES
      before :each do
        20.times do
          sp = SearchableProperty.create(adv_hash)
          sp.period.dates = period
          sp.country_code = 'DK'                      
        end      
        puts SearchableProperty.all #.map(&:inspect)
        Mongoid::Indexing.create_indexes
      end

      let(:full_exp) do
        {"type"=>"apartment", "address.country_code"=>"DK", "radius"=>10, "costs.monthly.total_rent"=>{"$gte"=>2000, "$lte"=>6000}, "size"=>{"$gte"=>50, "$lte"=>100}, "rooms"=>{"$gte"=>2, "$lte"=>3}, 
          "period.dates.from"=>{"$gte"=> search_period.start_date.to_i }, "period.dates.to"=>{"$lte"=> search_period.end_date.to_i }}
      end

      specify do
        subject.where_criteria.should == expected
      end

      let(:expected) do
        {"type"=>"apartment", "address.country_code"=>"DK", "costs.monthly.total_rent"=>{"$gte"=>2000, "$lte"=>6000}, "size"=>{"$gte"=>50, "$lte"=>100}, "rooms"=>{"$gte"=>2, "$lte"=>3}, "period.dates.from"=>{"$gte"=>1350597600}, "period.dates.to"=>{"$lte"=>1353189600}}
      end

      it 'should have only search results that match criteria' do
        search_result.size.should be_between(1, 10)
        search_result.each do |found|
          found.type.should         == 'apartment'
          found.rooms.should        be_between(2, 3)
          # found.shared.should       == true
          found.country_code.should == 'DK'
          found.latitude.should     be_within(0.00314).of(latitude)
          found.longitude.should    be_within(0.00314).of(longitude)
        end
        puts "RESULTS found: #{search_result.size}"
      end
    end
  end
end
  