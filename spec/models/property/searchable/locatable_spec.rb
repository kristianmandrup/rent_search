require 'spec_helper'

describe LocatableProperty do
  subject { create :valid_locatable_property }

  before do
    puts subject
    puts subject.address.city
    puts subject.position.to_a
  end

  describe 'Position' do
    specify do
      subject.position.to_a.should_not be_empty
    end
  end
end