# encoding: UTF-8

require 'spec_helper'

describe Search::Filter::HashApplier do
  subject { applier }

  def hash
    @hash ||= {cost: '7', size: 8, rooms: 1}
  end

  def search
    @search ||= Search.new
  end

  def non_hash
    search
  end

  let(:filter)        { Search::Filter.new }
  let(:only_filter)   { Search::Filter.new only: ['cost'] }
  let(:except_filter) { Search::Filter.new except: ['cost'] }

  def result; applier.apply.keys; end

  context 'applier' do
    context 'non-hash subject' do
      specify do 
        expect { Search::Filter::HashApplier.new filter, non_hash }.to raise_error(ArgumentError)
      end
    end

    context 'empty filter' do
      let(:applier) { Search::Filter::HashApplier.new filter, hash }

      # before do
      #   puts applier.to_s
      # end

      it 'should set hash' do
        applier.hash.should == hash
      end          

      it 'should set filter' do
        applier.filter.should == filter
      end          

      it 'should not remove any keys' do
        result.should == hash.keys
      end          
    end
  end

  context 'only applier' do
    let(:applier) { Search::Filter::HashApplier.new only_filter, hash }

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
    let(:applier) { Search::Filter::HashApplier.new except_filter, hash }

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