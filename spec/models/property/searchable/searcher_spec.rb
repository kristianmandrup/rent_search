require 'spec_helper'

Mongoid.logger = Logger.new($stdout)
Moped.logger   = Logger.new($stdout)

describe Property::Searcher do
  subject { searcher }

  let(:hash) do
    {:radius=>"any", :location=>"", :furnish=>"any", :rooms=>"any", :type=>"property", :size=>"any", :cost=>"2"}
  end

  context 'default criteria' do
    # search within 10kms of Copenhagen
    let(:searcher)  do
      Property::Searcher.new hash
    end

    let(:results) { searcher.search }

    before :all do
      10.times do
        # create :valid_searchable_room
        create :valid_property
      end
        
      puts "Creating indexes"
      puts "Searcher: #{searcher}"
      Mongoid::Indexing.create_indexes
    end

    specify do
      subject.where_criteria.should == {"address.country_code"=>"DK", "costs.monthly.total_rent"=>{"$gte"=>3000, "$lte"=>5000}}
    end

    specify do
      results.size.should == 4
    end    
  end  
end