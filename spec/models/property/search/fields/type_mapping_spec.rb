require 'spec_helper'

class TypeMappedDoc
  include BasicDocument

  include Property::Search::Fields::TypeMapping
end

describe Property::Search::Fields::TypeMapping do

  let(:clazz) { TypeMappedDoc }

  describe 'class methods' do
    subject { clazz }

    specify { subject.default_value(:furnishment).should == nil }

    specify { subject.field_types[:boolean].should == Boolean }

    specify { subject.type_names[:string].should include('furnishment') }

    specify do    
      subject.fields_for(:string).should include('country_code')
    end

    its(:criteria_types) { should include(:string) }

    its(:search_fields) { should include('types', 'shared') }    
    its(:all_fields)    { should include('types', 'shared') }
  end
end