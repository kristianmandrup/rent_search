require 'spec_helper'

describe Property::Criteria::Filter do
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

    let(:searcher) { Property::Searcher.new }
    let(:search) { searcher.search }

    let(:counter) { Property::Criteria::Filter::EnumCounter.new search }

    describe '.field_filterer' do
      specify do
        subject.field_filterer.should be_a(Property::FieldFilterer)
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
            subject.count_enums(:type)[key][enum].should > 0
          end
        end
      end
    end

    describe '.count_enums_for hash' do
      specify do
        puts "enums: #{subject.enum_criterias}"
        hash = subject.count_enums_for(type: ['apartment'])
        puts "hash for type:apartment #{hash}"
        hash[:type].should be_a Hash
        hash[:furnishment].should be_nil
      end
    end
  end
end