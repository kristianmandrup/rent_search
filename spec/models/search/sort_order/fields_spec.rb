require 'spec_helper'

class WithFields
  include BaseSearch::SortOrder::Calculator::Fields

  def desc_fields
    %w{cost}
  end

  def asc_fields
    %w{date cost}
  end
end  

describe BaseSearch::SortOrder::Calculator::Fields do
  subject { fields }

  let(:fields) { WithFields.new }

  describe 'fields' do
    specify { subject.fields(:asc).should include('date', 'cost') }
  end

  describe 'sort_fields' do
    specify { subject.sort_fields.map(&:to_s).should include('date', 'cost') }

    specify { subject.sort_fields.size.should == 2 }
  end
end