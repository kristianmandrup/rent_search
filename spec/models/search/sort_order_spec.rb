require 'spec_helper'

class SearchySortOrder < BaseSearch::SortOrder
  def calculator_class
    NiceSorter4
  end

  def allow_any_field?
    false
  end
end  

class NiceSorter4 < BaseSearch::SortOrder::Calculator
  def asc_fields
    %w{date cost created_at}
  end

  def desc_fields
    %w{cost}
  end

  def allow_any_field?
    false
  end
end

describe BaseSearch::SortOrder do
  subject { sort_order }

  context 'default sort order' do
    let(:sort_order) do
      SearchySortOrder.new
    end

    specify do
      subject.name.should == sort_order.default_field
    end

    it 'should set field' do
      subject.field.should_not be_nil
    end

    it 'should set field to default field' do
      subject.field.should == sort_order.default_field
    end

    it 'should calculate field as default field' do
      subject.calc.field.should == sort_order.default_field
    end

    it 'should set direction' do
      subject.direction.should_not be_nil
    end    

    it 'should set direction to default' do
      subject.direction.should == sort_order.default_direction
    end

    it 'should calculate direction as default' do
      subject.calc.direction.should == sort_order.default_direction
    end

    it 'should set sort_order' do
      subject.calculator.should_not be_nil
    end    

    it 'should set sort_order of sorter' do
      subject.calculator.sort_order.should == sort_order
    end    
  end

  context 'sort order cost, desc' do  
    let(:sort_order) do
      SearchySortOrder.new :cost, :desc
    end

    it 'should set name same as field' do
      subject.name.should == sort_order.field
    end

    it 'should set name to cost' do
      subject.name.should == :cost
    end

    it 'should set field' do
      subject.calc.field.should == :cost
    end

    it 'should set direction to desc' do
      subject.calc.direction.should == :desc
    end
  end

  context 'sort order date, desc' do  
    let(:sort_order) do
      SearchySortOrder.new :date, :desc
    end

    it 'should set name same as field' do
      subject.name.should == sort_order.field
    end

    it 'should set name to date' do
      subject.name.should == :date
    end

    it 'should set field to date' do
      subject.calc.field.should == :date
    end

    it 'should set direction to asc, since desc not valid' do
      subject.calc.direction.should == :asc
    end
  end
end