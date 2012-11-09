require 'spec_helper'

describe Property::Orderer do
  subject { order }

  context 'default' do
    let(:order) do
      Property::Orderer.new
    end

    specify { subject.direction.should == :asc }
  end

  context 'descender: rating' do
    let(:order) do
      Property::Orderer.new :rating
    end

    specify { subject.direction.should == :desc }
  end  

  context 'ascender: cost' do
    let(:order) do
      Property::Orderer.new :cost
    end

    specify { subject.direction.should == :asc }
  end

  # size_cost
end