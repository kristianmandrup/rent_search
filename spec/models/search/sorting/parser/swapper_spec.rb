require 'spec_helper'

class Swap  
  include ::BaseSearch::Sorting::Parser::Swapper

  attr_reader :sort_field, :sort_direction

  def initialize sort_field, sort_direction
    @sort_field, @sort_direction = [sort_field, sort_direction]
  end
end

describe BaseSearch::Sorting::Parser::Swapper do
  subject { swapper }

  let(:swapper) { Swap.new :asc, :cost }
  let(:non_swapper) { Swap.new :cost, :asc }

  describe 'swap!' do
    it 'should swap field and dir' do
      swap = swapper.swap!
      swap.sort_field.to_sym.should == :asc
      swap.sort_direction.to_sym.should == :cost
    end
  end

  describe 'direction?' do
    specify do
      swapper.direction?(:asc).should be_true
    end

    specify do
      swapper.direction?('desc').should be_true
    end

    specify do
      swapper.direction?('des').should be_false
    end
  end  
end