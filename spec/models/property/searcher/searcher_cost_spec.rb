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

  context 'searcher: total_rent(1) ' do
    subject { default_searcher }

    let(:default_searcher) do
      c = Property::Searcher.new total_rent: '1'
      puts c.inspect
      c
    end

    describe '.search' do
      let(:search_result) { subject.search }

      specify do
        subject.criteria.where_criteria.should == {"address.country_code"=>"DK", "cost"=>{"$gte"=>0, "$lte"=>3000}}
      end

      specify do
        SearchableProperty.all.count.should == 10
      end

      let(:range) { Property::Criteria::Mapper.map_for(:cost) }

      it 'should have only search results that match criteria' do
        search_result.size.should be_between(1, 10)
        puts "RESULTS found: #{search_result.size}"
        search_result.each do |found|
          puts "FOUND: #{found}"
          puts "Rent: #{found.total_rent}"
          
          found.total_rent.should <= range[1].max
          
          found.country_code.should == 'DK'
        end

        puts "RESULTS found: #{search_result.size}"
      end
    end
  end


  context 'cost order searcher' do
    subject { cost_order_searcher }

    let(:cost_order_searcher) do
      c = Property::Searcher.new total_rent: '1', order: :cost, page: 1
      puts c.inspect
      c
    end

    specify do
      SearchableProperty.all.count.should == 10
    end    

    describe '.execute' do
      let(:search_result) { subject.execute }

      specify do
        subject.criteria.where_criteria.should == {"address.country_code"=>"DK", "cost"=>{"$gte"=>0, "$lte"=>3000}}
      end

      let(:range) { Property::Criteria::Mapper.map_for(:cost) }

      it 'should have only search results that match criteria' do
        search_result.size.should be_between(1, 10)
        puts "RESULTS found: #{search_result.size}"
        last = 0
        last_created = 10.days.ago
        search_result.each do |found|
          puts "FOUND: #{found}"
          puts "Rent: #{found.total_rent}"

          found.total_rent.should >= last # should be sorted ascending!

          if found.total_rent == last
            found.created_at.should >= last_created # should always be sorted created_at ascending!
          end

          last = found.total_rent
          last_created = found.created_at
          
          found.total_rent.should <= range[1].max
          
          found.country_code.should == 'DK'
        end

        puts "RESULTS found: #{search_result.size}"
      end
    end    
  end    
end  