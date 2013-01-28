require 'spec_helper'

describe BaseSearch::Sorting::Mapper do
  subject { mapper }

  let(:clazz) { BaseSearch::Sorting::Mapper }

  describe 'init' do
    let(:mapper) { clazz.new 'cost::asc' }

    its(:sort_order) { should be_a BaseSearch::SortOrder }
  end

  describe 'field' do
    context 'not calculated' do
      let(:mapper) { clazz.new 'cost::asc' }

      specify { subject.field.to_sym.should == :cost }
    end
  end

  describe 'direction' do
    context 'not calculated' do
      let(:mapper) { clazz.new 'cost::asc' }

      specify { subject.direction.to_sym.should == :asc }
    end
  end

  describe 'map!' do
    let(:mapper) { clazz.new 'cost::asc' }    

    specify do
      mapper.map!
      subject.mapped?.should be_true
    end
  end

  describe 'mapped?' do
    let(:mapper) { clazz.new 'cost::asc' }    

    its(:mapped?) { should be_false }
  end

  describe 'calculator' do
    let(:mapper) { clazz.new 'cost::asc' }    

    its(:calculator) { should be_a BaseSearch::SortOrder::Calculator }

    specify do
      subject.calculator.sort_order.should == mapper.sort_order
    end
  end
end      
