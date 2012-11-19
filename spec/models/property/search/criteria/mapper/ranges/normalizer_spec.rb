require 'spec_helper'

describe Property::Search::Criteria::Mapper::Ranges::Normalizer do
  subject { normalizer }

  let(:clazz)      { Property::Search::Criteria::Mapper::Ranges::Normalizer }

  context 'size 50-100' do
    let(:normalizer) { clazz.new :size, '50-100' }

    describe '.init' do
      its(:key) { should == :size }
      its(:value) { should == '50-100' }
    end

    describe '.normalized' do
      its(:normalized) { should == (50..100) }
    end

    describe '.normalized_range range' do
      specify do
        subject.normalized_range(2..50).should == (5..50)
      end

      specify do
        subject.normalized_range(10..9000).should == (10..500)
      end
    end

    its(:range)         { should == (50..100) }
    its(:valid_range?)  { should be_true }
    its(:range_map)     { should be_a Hash }

    specify do
      subject.range_map[:size].should == (5..500)
    end

    describe 'a_range' do
      specify do
        subject.a_range("50-100").should == [50, 100]
      end
    end

    describe 'parse_plus' do
      specify do
        subject.parse_plus("+50").should == [50, 900000000]
      end
    end

    describe 'parse_minus' do
      specify do
        subject.parse_minus("50-").should == [0, 50]
      end
    end
  end

  context 'size +50' do
    let(:normalizer) { clazz.new :size, '+50' }

    describe 'range_of(value)' do
      specify do
        subject.range_of('+50').should == (50..900000000)
      end
    end

    describe '.normalized' do
      its(:normalized) { should == (50..500) }
    end
  end  

  context 'size 50-' do
    let(:normalizer) { clazz.new :size, '50-' }

    describe 'range_of(value)' do
      specify do
        subject.range_of('50-').should == (0..50)
      end
    end

    describe '.normalized' do
      its(:normalized) { should == (5..50) }
    end
  end

  context 'size 50-5000' do
    let(:normalizer) { clazz.new :size, '50-5000' }

    describe '.init' do
      its(:key) { should == :size }
      its(:value) { should == '50-5000' }
    end

    describe '.normalized' do
      its(:normalized) { should == (50..500) }
      
      specify do
        subject.normalized_range(50..500).should == (50..500)
      end
      
      its(:valid_range?) { should be_false }
      its(:range_map) { should be_a Hash }
    end
  end  
end