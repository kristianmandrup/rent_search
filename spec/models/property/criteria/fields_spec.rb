require 'spec_helper'

class FieldDoc
  include BasicDocument
  include Property::Criteria::Fields
end

describe Property::Criteria::Fields do

  let(:clazz) { FieldDoc }

  describe 'class methods' do
    subject { clazz }

    specify { subject.criteria_type_map.keys.should include(:string) }

    specify do    
      Property::Criteria.fields_for(:string).should include('country_code')
    end

    its(:search_fields) { should include('type', 'shared') }    
  end
end