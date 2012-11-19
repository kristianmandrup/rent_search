require 'spec_helper'

class FieldDoc
  include BasicDocument
  include Property::Search::Fields
end

describe Property::Search::Fields do

  let(:clazz) { FieldDoc }

  describe 'class methods' do
    subject { clazz }

    specify { subject.type_names.keys.should include(:string) }

    specify do    
      clazz.fields_for(:string).should include('country_code')
    end

    its(:search_fields) { should include('types', 'shared') }    
    its(:all_fields)    { should include('types', 'shared') }
  end

  describe 'Concerns' do
    describe 'type_mapping' do
      pending 'TODO - use shared ex'
    end

    describe 'setters' do
      pending 'TODO - use shared ex'
    end

    describe 'validations' do
      pending 'TODO - use shared ex'
    end

    describe 'sortable' do
      pending 'TODO - use shared ex'
    end
  end
end