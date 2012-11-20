require 'spec_helper'

describe Property::Search::Criteria::Filter::SelectCounter do
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

    # let(:searcher) { Property::Searcher.new }
    # let(:search)  { searcher.search }

    let(:search)      { create :valid_property_search }
    let(:criteria)    { search.execute }

    let(:counter) { Property::Search::Criteria::Filter::SelectCounter.new criteria }

    # TODO: test caching!

    describe '.select_criterias' do
      specify do
        puts "select_criterias = #{subject.select_criterias}"

        subject.select_criterias.should be_a(Hash)
        subject.select_criterias.should_not be_empty
      end
    end

    describe '.count_selects' do
      specify do
        puts "selects: #{subject.select_criterias}"
        subject.select_criterias[:selected].each do |enum|
          subject.count_selects[enum].should > 0
        end
      end
    end

    describe '.count_selects fields' do
      specify do
        puts "selects: #{subject.select_criterias}"
        subject.select_criterias[:selected].each do |enum|
          subject.count_selects(:parking)[enum].should > 0
        end
      end
    end
  end
end