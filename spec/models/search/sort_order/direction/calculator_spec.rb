require 'spec_helper'

class NiceSorter < Search::SortOrder::Calculator
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

class SortyOrder < Search::SortOrder
  def calculator_class
    NiceSorter
  end
end


describe Search::SortOrder::Calculator::Direction::Calculator do
  # subject { calculator }

  let(:order_clazz) { SortyOrder }

  let(:calc_class) { Search::SortOrder::Calculator::Direction::Calculator }

  describe 'init' do
    context 'invalid field' do
      specify do
        expect { calc_class.new sort_order }.to raise_error
      end

      let(:sort_order) do
        order_clazz.new :invalid, :desc
      end
    end

    context 'invalid direction' do
      specify do
        expect { calc_class.new sort_order }.to raise_error
      end

      let(:sort_order) do
        order_clazz.new :cost, :invalid
      end
    end

    # date should only allow sorting in ascending order, (soonest first)
    context 'invalid direction for field' do
      let(:calculator) do
        calc_class.new sort_order
      end

      let(:sort_order) do
        order_clazz.new :date, :desc
      end

      specify {
        sort_order.allow_any_field?.should be_false
      }

      specify {
        calculator.allow_any_field?.should be_false
      }

      it 'should reverse direction to valid for field' do
        calculator.calc.should == :asc
      end      
    end

    # date should only allow sorting in ascending order, (soonest first)
    context 'valid direction for field' do
      let(:calculator) do
        calc_class.new sort_order
      end

      let(:sort_order) do
        order_clazz.new :date, :asc
      end

      specify do
        calculator.calc.should == :asc
      end      
    end
  end

  describe 'calc' do
    context 'allows only one direction for :date' do
      let(:calculator) do
        calc_class.new sort_order
      end

      let(:sort_order) do
        order_clazz.new :date, :asc
      end

      specify do
        calculator.calc.should == :asc
      end      

      it 'should not allow new direction' do
        calculator.calc(:desc).should == :asc
      end
    end

    context 'allows both directions for :cost' do
      let(:calculator) do
        calc_class.new sort_order
      end

      let(:sort_order) do
        order_clazz.new :cost, :asc
      end

      specify do
        calculator.calc.should == :asc
      end      

      it 'should not allow new direction' do
        calculator.calc(:desc).should == :desc
      end
    end

    context 'allows desc for :cost' do
      let(:calculator) do
        calc_class.new sort_order
      end

      let(:sort_order) do
        order_clazz.new :cost, :desc
      end

      specify do
        calculator.calc.should == :desc
      end      
    end    
  end
end