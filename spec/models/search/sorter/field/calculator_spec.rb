require 'spec_helper'

class NiceSorter2 < Search::Sorter
  def asc_fields
    %w{date cost}
  end

  def desc_fields
    %w{cost}
  end
end

class SortyOrder2 < Search::SortOrder
  def sorter_class
    NiceSorter2
  end
end

describe Search::Sorter::Field::Calculator do
  subject { calculator }  

  let(:order_clazz) { SortyOrder2 }

  let(:calculator) do
    Search::Sorter::Field::Calculator.new sort_order
  end

  let(:sort_order) do
    order_clazz.new :cost, :invalid
  end

  describe 'calc' do
    it 'should set valid field date' do
      calculator.calc(:date)
      calculator.field.should == :date
    end

    it 'should not set valid field date but use default' do
      calculator.calc(:invalid)
      calculator.field.should == calculator.default_field
    end
  end

  describe 'valid?' do
    it 'date is valid' do
      calculator.valid_field?(:date).should be_true
    end

    it 'invalid' do
      calculator.valid_field?(:invalid).should be_false
    end    
  end
end