require 'spec_helper'

class NiceSorter2 < BaseSearch::SortOrder::Calculator
  def allow_any_field?
    false
  end

  def asc_fields
    %w{date cost}
  end

  def desc_fields
    %w{cost}
  end
end

class SortyOrder2 < BaseSearch::SortOrder
  def calculator_class
    NiceSorter2
  end

  def allow_any_field?
    false
  end
end

describe BaseSearch::SortOrder::Calculator::Field::Calculator do
  subject { calculator }  

  let(:order_clazz) { SortyOrder2 }

  let(:calculator) do
    BaseSearch::SortOrder::Calculator::Field::Calculator.new sort_order
  end

  let(:sort_order) do
    order_clazz.new :cost, :desc
  end

  describe 'calc' do
    it 'should set valid field date' do
      calculator.valid_field?(:date).should be_true

      calculator.calc(:date)
      calculator.field_name.should == :date
    end

    it 'should not set valid field date but use default' do
      calculator.calc(:invalid)

      calculator.valid_field?(:invalid).should be_false

      calculator.field_name.should == calculator.default_field
    end
  end

  describe 'valid?' do
    it 'date is valid' do
      calculator.valid_field?(:date).should be_true
    end

    it 'date is valid' do
      calculator.valid_field?(:cost).should be_true
    end

    it 'invalid' do
      calculator.valid_field?(:invalid).should be_false
    end    
  end
end