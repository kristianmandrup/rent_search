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

  context 'size < 40' do
    let(:normalizer) { clazz.new :size, '< 40' }

    describe 'range_of(value)' do
      specify do
        subject.range_of('< 40').should == (0..39)
      end
    end
  end

  context 'size > 120' do
    let(:normalizer) { clazz.new :size, '> 120' }

    describe 'range_of(value)' do
      specify do
        subject.range_of('> 120').should == (121..900000000)
      end
    end
  end

  context 'size less than 120' do
    let(:normalizer) { clazz.new :size, 'less than 120' }

    describe 'range_of(value)' do
      specify do
        subject.range_of('less than 120').should == (0..119)
      end
    end
  end

  context 'size more than 120' do
    let(:normalizer) { clazz.new :size, 'more than 120' }

    describe 'range_of(value)' do
      specify do
        subject.range_of('more than 120').should == (121..900000000)
      end
    end
  end

  context 'size 120 or more ' do
    let(:normalizer) { clazz.new :size, '120 or more' }

    describe 'range_of(value)' do
      specify do
        subject.range_of('120 or more').should == (120..900000000)
      end
    end
  end

  context 'size 120 or less' do
    let(:normalizer) { clazz.new :size, '120 or less' }

    describe 'range_of(value)' do
      specify do
        subject.range_of('120 or less').should == (0..120)
      end
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