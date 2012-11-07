require 'spec_helper'

describe Property::Criteria::Mapper::Normalizer do
  subject { normalizer }

  context 'size 50-100' do
    let(:normalizer) { Property::Criteria::Mapper::Normalizer.new :size, '50-100' }

    describe '.init' do
      its(:key) { should == :size }
      its(:value) { should == '50-100' }
    end

    describe '.normalized' do
      its(:normalized) { should == (50..100) }
      its(:normalized_range) { should == (5..1000) }
      its(:range) { should == (50..100) }
      its(:valid_range?) { should be_true }
      its(:range_map) { should be_a Hash }
    end
  end

  context 'size 50-5000' do
    let(:normalizer) { Property::Criteria::Mapper::Normalizer.new :size, '50-5000' }

    describe '.init' do
      its(:key) { should == :size }
      its(:value) { should == '50-5000' }
    end

    describe '.normalized' do
      its(:normalized) { should == (5..1000) }
      its(:normalized_range) { should == (5..1000) }
      its(:valid_range?) { should be_false }
      its(:range_map) { should be_a Hash }
    end
  end  
end