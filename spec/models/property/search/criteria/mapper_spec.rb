require 'spec_helper'

describe Property::Search::Criteria::Mapper do
  subject { mapper }

  context 'with default preferences' do
    let(:mapper) { Property::Search::Criteria::Mapper.build criteria_hash }

    let(:criteria_hash) do
      {"radius"=>"any", "location"=>"", "furnish"=>"any", "rooms"=>"any", "type"=>"property", "size"=>"any", "cost"=>"500-3000", "period_from"=>"", "period_to"=>""}
    end

    describe 'mapped criteria' do
      specify {
        subject.mapped_hash.should == {cost: 500..3000}
      }
    end
  end

  context 'with preferences' do
    let(:mapper) { Property::Search::Criteria::Mapper.build criteria_hash, preferences }

    let(:preferences) do
      Property::Search::Preferences.new area_unit: 'sqfeet'
    end

    let(:criteria_hash) do
      {"radius"=>"any", "location"=>"", "furnish"=>"any", "rooms"=>"any", "type"=>"property", "size"=>"10-100", "period_from"=>"", "period_to"=>""}
    end

    # TODO: Map to sqfeet from criteria?
    describe 'mapped criteria' do
      specify {
        subject.mapped_hash.should == {sqfeet: 10..100}
      }
    end
  end
end