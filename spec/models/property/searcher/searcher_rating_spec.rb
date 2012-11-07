require 'spec_helper'

describe Property::Searcher do
  include ::CriteriaSpecHelper

  # RANDOM PROPERTIES
  before :each do
    10.times do |n|
      Delorean.time_travel_to(n.minutes.from_now) do
        create :valid_searchable_property
      end
    end
    puts SearchableProperty.all #.map(&:inspect)
    # Mongoid::Indexing.create_indexes
  end        

  context 'searcher: rating(1) ' do
    subject { default_searcher }

    let(:default_searcher) do
      c = Property::Searcher.new rating: 1
      puts c.inspect
      c
    end

    describe '.search' do
      let(:search_result) { subject.search }

      specify do
        subject.criteria.where_criteria.should == {"address.country_code"=>"DK", "rating"=>{"$gte"=>1, "$lte"=>2}}
      end

      specify do
        SearchableProperty.all.count.should == 10
      end

      let(:range) { Property::Criteria::Mapper.map_for(:rating) }

      it 'should have only search results that match criteria' do
        search_result.size.should be_between(1, 10)
        puts "RESULTS found: #{search_result.size}"
        search_result.each do |found|
          puts "FOUND: #{found}"
          puts "Rating: #{found.rating}"
          
          found.rating.should <= range[1].max          
        end

        puts "RESULTS found: #{search_result.size}"
      end
    end
  end
end