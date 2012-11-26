require 'spec_helper'

describe Search::SortOrder::Validation do
  subject { calculator }

  context 'valid_direction?' do
    let(:calculator) do
      Property::Search::SortOrder::Calculator.new(sort_order).calc
    end

    let(:sort_order) { Search::SortOrder.new :date, :asc }

    describe 'dir_fields(dir)' do
      specify { subject.dir_fields(:asc).should include(:date) }
      specify { subject.dir_fields(:desc).should_not include(:date) }
    end

    describe 'valid_direction?' do
      specify { subject.valid_direction?(:asc).should be_true }
      specify { subject.valid_direction?(:desc).should be_true }
    end

    describe 'valid_direction?' do
      specify { subject.valid_field_direction?(:asc).should be_true }
      specify { subject.valid_field_direction?(:desc).should be_false }
    end

    describe 'sort_fields' do
      specify { subject.send(:sort_fields).should include(:date) }
    end

    describe 'valid_field?' do
      specify { subject.valid_field?(:date).should be_true }
      specify { subject.valid_field?(:published_at).should be_false }
    end
  end
end
