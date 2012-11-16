require 'spec_helper'

class NiceSorter3 < Search::SortOrder::Calculator
  def asc_fields
    %w{date cost created_at}
  end

  def desc_fields
    %w{cost}
  end
end

class SortyOrdering < Search::SortOrder
  def calculator_class
    NiceSorter3
  end
end

describe Search::SortOrder::Calculator do
  subject { sorter }

  let(:sorter_clazz) { NiceSorter3 }

  let(:sort_order_clazz) { SortyOrdering }

  let(:sorter) { sorter_clazz.new sort_order }  

  context 'default' do
    let(:sort_order) { sort_order_clazz.new }

    describe 'calc!' do
      describe 'direction' do
        specify { subject.calc.direction.should == subject.default_direction }
      end

      describe 'field' do
        specify { subject.calc.field.should == subject.default_field }
      end
    end
  end

  context 'descender: date' do
    let(:sort_order) { sort_order_clazz.new :date, :desc }

    describe 'calc!' do
      describe 'direction' do
        specify { subject.calc!.direction.should == :asc }
      end

      describe 'field' do
        specify { subject.calc.field.should == :date }
      end
    end
  end

  context 'descender: cost' do
    let(:sort_order) { sort_order_clazz.new :cost, :desc }

    describe 'calc!' do
      describe 'direction' do
        specify { subject.calc!.direction.should == :desc }
      end

      describe 'field' do
        specify { subject.calc.field.should == :cost }
      end
    end
  end  

  context 'ascender: cost' do
    let(:sort_order) { sort_order_clazz.new :cost, :asc }

    describe 'calc!' do
      describe 'direction' do
        specify { subject.calc!.direction.should == :asc }
      end

      describe 'field' do
        specify { subject.calc.field.should == :cost }
      end
    end
  end
end