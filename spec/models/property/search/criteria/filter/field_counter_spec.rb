require 'spec_helper'

describe Property::Search::Criteria::Filter::FieldCounter do
  subject { field_counter }

  let(:clazz)             { Property::Search::Criteria::Filter::FieldCounter }

  let(:default_criteria)  { SearchableProperty.all }

  describe 'Invalid search criteria argument' do
    let(:search) { create :valid_property_search }

    specify do
      expect { clazz.new search }.to raise_error(ArgumentError)
    end
  end

  describe 'valid search criteria argument' do
    specify do
      expect { clazz.new default_criteria }.to_not raise_error
    end
  end

  describe 'valid search criteria argument' do
    let(:field_counter) { clazz.new default_criteria }

    its(:search) { should == default_criteria }

    specify do
      subject.field_selector.property_list.size.should == default_criteria.to_a.size
    end
  end
end
