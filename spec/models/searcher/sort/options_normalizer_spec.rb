require 'spec_helper'

describe Searcher::Sort::OptionsNormalizer do
  subject { normalized }

  let(:clazz) { Searcher::Sort::OptionsNormalizer }
  let(:normalized) { normalizer.normalize }

  describe 'hash args' do
    let(:normalizer) do
      clazz.new field: 'cost', direction: 'asc'
    end

    specify do
      subject[:field].should == :cost
    end

    specify do
      subject[:direction].should == :asc
    end
  end

  describe 'array args' do
    let(:normalizer) do
      clazz.new 'cost', 'asc'
    end

    specify do
      subject[:field].should == :cost
    end

    specify do
      subject[:direction].should == :asc
    end
  end  

  describe 'unflattened array args' do
    let(:normalizer) do
      clazz.new [[:cost, :asc]]
    end

    specify do
      subject[:field].should == :cost
    end

    specify do
      subject[:direction].should == :asc
    end
  end  

  describe 'array args reverse' do
    let(:normalizer) do
      clazz.new 'asc', 'cost'
    end

    specify do
      subject[:field].should == :cost
    end

    specify do
      subject[:direction].should == :asc
    end
  end    
end