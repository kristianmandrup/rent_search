# encoding: UTF-8

require 'spec_helper'

class SearchApply < Search
  field :cost,  type: Integer, default: 1
  field :rooms, type: Integer, default: 1
  field :size,  type: Integer, default: 1

  def set_fields
    self.class.all_fields.select{|f| self.send(f) != nil }.map(&:to_sym)
  end

  def self.all_fields
    %w{cost size rooms}
  end
end

describe Search::Filter::SearchApplier do
  subject { applier }

  def hash
    @hash ||= {cost: '7', size: 8, rooms: 1}
  end

  def search
    @search ||= SearchApply.create cost: 1
  end

  def non_search
    hash
  end

  let(:filter)        { Search::Filter.new }
  let(:only_filter)   { Search::Filter.new only: ['cost'] }
  let(:except_filter) { Search::Filter.new except: ['cost'] }

  def result; applier.apply.set_fields; end

  context 'applier' do
    context 'non-search subject' do
      specify do 
        expect { Search::Filter::SearchApplier.new filter, non_search }.to raise_error(ArgumentError)
      end
    end

    context 'empty filter' do
      let(:applier) { Search::Filter::SearchApplier.new filter, search }

      # before do
      #   puts applier.to_s
      # end

      it 'should set search' do
        applier.search.should == search
      end          

      it 'should set filter' do
        applier.filter.should == filter
      end          

      it 'should not remove any keys' do
        result.should == SearchApply.all_fields.map(&:to_sym)
      end          
    end
  end

  context 'only applier' do
    let(:applier) { Search::Filter::SearchApplier.new only_filter, search }

    # before do
    #   puts applier.to_s
    # end

    it 'should remove cost' do
      result.should_not include(:cost)
    end    

    it 'should not remove others' do
      result.should include(:size, :rooms)
    end    
  end

  context 'except applier' do
    let(:applier) { Search::Filter::SearchApplier.new except_filter, search }

    # before do
    #   puts applier.to_s
    # end

    it 'should keep cost' do
      result.should include(:cost)
    end

    it 'should remove all others' do
      result.should_not include(:size, :rooms)
    end
  end
end