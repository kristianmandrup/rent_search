require 'spec_helper'

describe Property::Search::Criteria::Filter do
  context '10 valid properties' do
    before :each do
      5.times do |n|
        Delorean.time_travel_to(n.minutes.from_now) do
          create :valid_searchable_property
        end
      end
      # puts SearchableProperty.all.map(&:cost).join(", ")
      # puts SearchableProperty.all.map(&:sqm).join(", ")
    end
    
    subject { counter }

    # let(:searcher)  { Property::Searcher.new }
    # let(:search)    { searcher.execute }

    let(:search)      { create :valid_property_search }    
    # let(:criteria)    { search.where }
    let(:criteria)    { SearchableProperty.all }

    let(:counter) { Property::Search::Criteria::Filter::RangeCounter.new criteria }

    describe '.search' do
      specify do
        subject.search.should == criteria
      end
    end

    describe '.min' do
      specify do
        puts "min(:cost) = #{subject.min(:cost)}"
        subject.min(:cost).should > 0
      end      
    end

    describe '.max' do
      specify do
        puts "max(:cost) = #{subject.max(:cost)}"
        subject.max(:cost).should < 10000
      end      
    end

    describe '.range' do
      specify do
        puts "range(:cost) = #{subject.range(:cost).inspect}"
        subject.range(:cost).should be_a(Range)
      end      
    end

    describe '.ranges' do
      specify do
        puts "ranges(:cost, :sqm, :rooms) = #{subject.ranges(:cost, :sqm, :rooms)}"

        rooms = subject.ranges(:cost, :sqm, :rooms)[:rooms]
        rooms.should be_a(Range)
        rooms.min.should be_a(Integer)
        rooms.max.should be_a(Integer)

        rooms.min.should >= 1
        rooms.max.should <= 5
        rooms.min.should <= rooms.max
      end      
    end

    describe '.range_criterias' do
      specify do
        puts "range_criterias = #{subject.range_criterias}"

        subject.range_criterias.should be_a(Hash)
        subject.range_criterias.should_not be_empty
      end
    end

    # TODO: test caching!

    describe '.count_range' do
      specify do        
        subject.count_range(:cost, 2000..3000).should > 0
        subject.count_range(:sqm, 20..71).should > 0
      end
    end

    describe '.count_ranges' do
      specify do
        ranges = subject.count_ranges(cost: [2000..3000, 3000..4000], sqm: 20..71)
        ranges.should be_a Hash
        ranges.should_not be_empty
        ranges[:cost]['2000..3000'].should > 0
        ranges[:cost]['3000..4000'].should > 0
        ranges[:sqm]['20..71'].should > 0
      end
    end

    describe '.count_ranges' do
      specify do    
        puts "limits cost: #{subject.range_limits(:cost)}"
        subject.range_limits(:cost).should be_an Array
        subject.range_limits(:cost).should_not be_empty
      end
    end

    describe '.count_ranges' do
      specify do    
        ranges = subject.range_limits(:sqm, min_step: 5)
        puts "limits sqm: #{ranges}"
        ranges.should be_an Array
        ranges.should_not be_empty
      end
    end
    describe '.count_ranges' do
      specify do    
        ranges = subject.range_field_limits(cost: {}, sqm: {min_step: 5})
        puts "limits: #{ranges}"
        ranges.should be_a Hash
        ranges.should_not be_empty
      end
    end
  end
end