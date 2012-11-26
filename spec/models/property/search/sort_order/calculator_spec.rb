require 'spec_helper'

describe Property::Search::SortOrder::Calculator do
  subject { calculator }

  context 'default' do
    let(:calculator) do
      Property::Search::SortOrder::Calculator.new
    end

    specify { subject.field.should == :created_at }
    specify { subject.direction.should == :asc }
  end

  context 'rating :asc' do
    let(:calculator) do
      Property::Search::SortOrder::Calculator.build(:rating, :asc).calc!
    end

    specify { subject.default_fields.should be_a Hash }
    specify { subject.default_fields[:cost].should == :asc }
  end

  context 'rating :desc' do
    let(:calculator) do
      Property::Search::SortOrder::Calculator.build(:rating, :desc).calc!
    end

    specify { subject.field.should == :rating }

    # force descending order
    specify { subject.direction.should == :desc }
  end  

  context 'cost :desc' do
    let(:calculator) do
      Property::Search::SortOrder::Calculator.build(:cost, :desc).calc!
    end

    specify { subject.field.should == :cost }
    specify { subject.direction.should == :desc }
  end
end