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

  context 'descender: rating' do
    let(:calculator) do
      Property::Search::SortOrder::Calculator.new :rating, :asc
    end

    specify { subject.field.should == :rating }

    # force descending order
    specify { subject.direction.should == :desc }
  end  

  context 'ascender: cost' do
    let(:calculator) do
      Property::Search::SortOrder::Calculator.new :cost, :desc
    end

    specify { subject.field.should == :cost }
    specify { subject.direction.should == :desc }
  end
end