require 'spec_helper'

class Validating
  include BaseSearch::SortOrder::Calculator::Field::Validation

  def allow_any_field?
    false
  end

  def sort_fields
    %w{date cost}
  end
end

describe BaseSearch::SortOrder::Calculator::Field::Validation do
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