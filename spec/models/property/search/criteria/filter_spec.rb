require 'spec_helper'

describe Property::Search::Criteria::Filter do
  subject { criteria_filter }

  def field_clazz_for name
    "Property::#{name.to_s.camelize}".constantize
  end

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
    
    let(:searcher) { Property::Searcher.new }

    let(:criteria_filter) { Property::Search::Criteria::Filter.new searcher }

    describe '.search' do
      specify do
        subject.search.should be_a(Mongoid::Criteria)
        subject.search.options.should_not be_empty
        subject.search.selector.should_not be_empty
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

    describe '.enum_criterias' do
      specify do
        puts "enum_criterias = #{subject.enum_criterias}"

        subject.enum_criterias.should be_a(Hash)
        subject.enum_criterias.should_not be_empty
      end
    end

    # TODO: test caching!

    describe '.select_criterias' do
      specify do
        puts "select_criterias = #{subject.select_criterias}"

        subject.select_criterias.should be_a(Hash)
        subject.select_criterias.should_not be_empty
      end
    end

    # TODO: test caching!    

    describe '.all' do
      specify do
        puts "all = #{subject.all}"

        subject.all.should be_a(Hash)
        subject.all.should_not be_empty
      end
    end

    describe '.counts_for hash' do
      specify do
        res = subject.counts_for(ranges: {cost: [2000..3000, 3000..4000]}, enums: [:type])
        puts res[:type]
        res[:type].should be_a Hash
        res[:type].keys.size.should > 1
      end
    end

    describe '.counts_for hash' do
      specify do
        res = subject.counts_for(ranges: {cost: [2000..3000, 3000..4000]}, enums: {type: ['apartment']})
        puts res[:type]
        res[:type].should be_a Hash
        res[:type].keys.size.should <= 1
      end
    end
  end
end