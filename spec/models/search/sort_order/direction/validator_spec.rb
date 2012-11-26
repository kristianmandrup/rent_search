require 'spec_helper'

class DirValidator
  include Search::SortOrder::Calculator::Direction::Validator

  attr_reader :field, :direction

  def initialize field, direction
    @field, @direction = [field, direction]
  end

  alias_method :sort_direction, :direction
  alias_method :sort_field, :field
  alias_method :name, :field

  def default_direction
    :asc
  end

  def default_field
    :date
  end

  def sort_fields_for dir = :asc
    send "#{dir}_fields"
  end

  def allow_any_field?
    false
  end

  def asc_fields
    %w{date cost}
  end

  def desc_fields
    %w{cost}
  end

  alias_method :direction, :sort_direction
  alias_method :field, :sort_field
end

class EmptyDirValidator
  include Search::SortOrder::Calculator::Direction::Validator

  def sort_fields_for dir = :asc
    send "#{dir}_fields"
  end

  def asc_fields
    []
  end

  def desc_fields
    []
  end
end

describe Search::SortOrder::Calculator::Direction::Validator do
  subject { validator }

  let(:validator)   { DirValidator.new :cost, :desc }
  let(:invalidator) { DirValidator.new :cost, :invalid } 
  let(:empty_dirvalidator) { EmptyDirValidator.new } 

  describe 'validate_direction!' do
    it 'should set default direction if dir is NOT valid' do
      invalidator.validate_direction!
      invalidator.direction.should == validator.default_direction
    end

    it 'should not set default direction if dir is valid' do
      validator.validate_direction!
      validator.direction.should == :desc
    end
  end

  describe 'valid_direction?' do
    context 'invalid dir' do
      specify do
        validator.valid_direction?(:invalid).should == false
      end      
    end

    specify do
      validator.valid_direction?(:asc).should == true
    end

    specify do
      validator.valid_direction?(:desc).should == true
    end
  end

  describe 'set_default' do
    specify do
      validator.set_default!.direction.should == validator.default_direction
    end
  end

  context 'date field validator' do
    let(:validator) { DirValidator.new :date, :desc }

    describe 'valid_field_direction?' do    
      context 'asc valid for date' do
        specify do
          validator.valid_field_direction?(:asc).should be_true
        end    
      end

      context 'desc not valid for date' do
        specify do
          validator.valid_field_direction?(:desc).should be_false
        end    
      end
    end

    describe 'dir_fields' do
      context 'desc empty' do
        let(:validator) { EmptyDirValidator.new }

        specify do
          validator.dir_fields(:desc).should be_empty
        end    
      end

      context 'asc not empty' do
        specify do
          validator.dir_fields(:asc).should_not be_empty
        end    

        specify do
          validator.dir_fields(:desc).should include(:cost)
        end    

        specify do
          validator.dir_fields(:asc).should include(:date, :cost)
        end    
      end
    end
  end
end