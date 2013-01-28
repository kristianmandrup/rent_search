require 'spec_helper'

class Searchy < BaseSearch
  def self.all_fields
    %w{cost size rooms}
  end
end

describe BaseSearch::Filter do
  subject { filter }

  let(:hash) do
    {cost: '7', size: 8, rooms: 1}
  end

  let(:search) do
    Searchy.create cost: '7', size: 8, rooms: 1
  end

  context 'filter' do
    let(:filter) { BaseSearch::Filter.new }
  end

  context 'Hash' do
    def result
      filter.applier_for(hash).apply.keys
    end

    context 'only filter' do
      let(:filter) { BaseSearch::Filter.new only: ['cost'] }

      it 'should remove cost' do
        result.should_not include(:cost)
      end    

      it 'should not remove others' do
        result.should include(:size, :rooms)
      end    
    end

    context 'except filter' do
      let(:filter) { BaseSearch::Filter.new except: ['cost'] }

      it 'should keep cost' do
        result.should include(:cost)
      end

      it 'should remove all others' do
        result.should_not include(:size, :rooms)
      end
    end
  end

  context 'Search' do
    def result
      filter.applier_for(search).apply.set_fields
    end

    context 'only filter' do
      let(:filter) { BaseSearch::Filter.new only: ['cost'] }

      it 'should remove cost' do
        result.should_not include(:cost)
      end    

      it 'should not remove others' do
        result.should include(:size, :rooms)
      end    
    end

    context 'except filter' do
      let(:filter) { BaseSearch::Filter.new except: ['cost'] }

      it 'should keep cost' do
        result.should include(:cost)
      end

      it 'should remove all others' do
        result.should_not include(:size, :rooms)
      end
    end
  end  
end