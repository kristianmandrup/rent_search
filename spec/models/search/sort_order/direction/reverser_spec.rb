require 'spec_helper'

class Reversed
  include BaseSearch::SortOrder::Calculator::Direction::Reverser
  
  attr_reader :field, :direction

  def initialize field, direction
    @field, @direction = [field, direction]
  end

  alias_method :sort_direction, :direction
  alias_method :sort_field, :field
end

describe BaseSearch::SortOrder::Calculator::Direction::Reverser do
  subject { reverser }

  let(:reverser) { Reversed.new :cost, :desc }

  describe 'reverse' do
    before do
      @reverse_dir = reverser.reverse
    end

    specify do
      @reverse_dir.should == :asc
    end

    specify do
      reverser.direction.should == :desc
    end
  end

  describe 'reverse!' do
    specify do
      reverser.reverse!.direction.should == :asc
    end
  end
end