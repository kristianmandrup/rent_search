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

    # let(:searcher) { Property::Searcher.new }
    # let(:search)   { searcher.search }

    let(:search)      { create :valid_property_search }
    let(:criteria)    { search.execute }    

    let(:counter) { Property::Search::Criteria::Filter::EnumCounter.new criteria }

    describe '.field_selector' do
      specify do
        subject.field_selector.should be_a(Property::Search::Criteria::Filter::FieldSelector)
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

    describe '.count_enums' do
      specify do
        puts "enums: #{subject.enum_criterias}"
        subject.enum_criterias.each do |key, list|
          list.each do |enum|
            subject.count_enums[key][enum].should > 0
          end
        end
      end
    end

    describe '.count_enums fields' do
      specify do
        puts "enums: #{subject.enum_criterias}"
        subject.enum_criterias.each do |key, list|
          list.each do |enum|
            subject.count_enums(:types)[key][enum].should > 0
          end
        end
      end
    end

    describe '.count_enums_for hash' do
      specify do
        puts "enums: #{subject.enum_criterias}"
        hash = subject.count_enums_for(types: ['apartment'])

        # puts "hash for type:apartment #{hash}"
        hash[:types].should be_a Hash
        hash[:furnishment].should be_nil
      end
    end
  end
end