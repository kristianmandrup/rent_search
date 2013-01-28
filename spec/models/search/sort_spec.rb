require 'spec_helper'

describe BaseSearch::Sort do
  subject { sort }

  let (:sort) do
    BaseSearch::Sort.new
  end

  describe 'class methods' do
    describe 'default_name' do
      specify { BaseSearch::Sort.default_name.should == :created_at }
    end

    describe 'default_name' do
      specify { BaseSearch::Sort.valid_sort_fields.should == [:created_at] }
    end
  end

  describe 'name' do
    its(:name) { should == 'created_at' }
  end

  describe 'direction' do
    its(:direction) { should == 'asc' }
  end

  describe 'name=' do
    context 'valid name' do
      before do
        subject.name = 'created_at'
      end
      
      its(:name) { should == 'created_at' }
    end

    context 'invalid name' do
      before do
        subject.name = 'hello'
      end
      
      its(:name) { should == 'created_at' }
    end
  end
end