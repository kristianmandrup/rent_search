require 'spec_helper'

class Normalized
  include Search::SortOrder::Calculator::Direction::Normalizer

  attr_reader :field, :direction

  def initialize field, direction
    @field, @direction = [field, direction]
  end

  alias_method :sort_direction, :direction
  alias_method :sort_field, :field
  
  def default_direction
    :asc
  end

  def default_field
    :date
  end

  def sort_fields_for dir = :asc
    send "#{dir}_fields"
  end

  def asc_fields
    %w{date cost}
  end

  def desc_fields
    %w{cost}
  end

  def sort_fields
    sort_fields ||= begin
      [:asc, :desc].each do |dir|
        raise "#{dir}_fields must be an Array" unless send("#{dir}_fields").kind_of?(Array)
      end
      asc_fields | desc_fields
    end
  end
end

describe Search::SortOrder::Calculator::Direction::Normalizer do
  subject { normalizer }

  describe 'normalize!' do
    context 'invalid field' do
      let(:normalizer) { Normalized.new :invalid, direction }

      let(:direction) { :desc }

      before do
        normalizer.normalize!
      end

      it 'should set field to default' do
        normalizer.field.should == :invalid # normalizer.default_field
      end

      it 'should set direction to default' do
        normalizer.direction.should == normalizer.default_direction
      end      
    end

    context 'invalid direction for field' do
      let(:normalizer) { Normalized.new :date, :desc }

      let(:direction) { :desc }

      before do
        normalizer.normalize!
      end

      specify do
        normalizer.field.should == :date
      end

      specify do
        normalizer.direction.should == :asc
      end
    end    

    context 'valid direction for field' do
      let(:normalizer) { Normalized.new :date, direction }

      let(:direction) { :asc }

      before do
        normalizer.normalize!
      end

      specify do
        normalizer.field.should == :date
      end

      specify do
        normalizer.direction.should == direction
      end
    end    
  end
end