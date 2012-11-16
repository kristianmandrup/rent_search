require 'spec_helper'

class Validating
  include Search::Sorter::Field::Validation

  def sort_fields
    %w{date cost}
  end
end

describe Search::Sorter::Field::Validation do
  subject { validating }

  let(:validating) { Validating.new }

  describe 'sort_fields' do
    it 'should have' do
      subject.sort_fields.should_not be_empty
    end
  end

  describe 'valid_field?' do
    it ':cost is valid' do
      subject.valid_field?(:cost).should be_true
    end

    it 'invalid' do
      subject.valid_field?(:cost).should be_true
    end
  end
end