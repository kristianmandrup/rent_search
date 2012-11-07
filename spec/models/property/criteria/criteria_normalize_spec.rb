require 'spec_helper'

class SettersDoc
  include BasicDocument

  include Property::Criteria::Fields
  include Property::Criteria::Setters
end

describe 'Property::Criteria::Setters Normalization' do

  let(:clazz) { SettersDoc }

  def default name
    clazz.criteria_default name
  end

  describe 'do NOT allow type room with # of rooms defined' do
    subject { clazz.create rooms: '1', type: 'room' }

    its(:rooms)       { should == default(:rooms) }
    its(:type)        { should == 'room' }
  end
end