require 'spec_helper'

describe Search::Filter do
  subject { filter }

  let(:hash) do
    {cost: '7', size: 8, rooms: 1}
  end

  context 'filter' do
    let(:filter) { Search::Filter.new }

  end

  context 'only filter' do
    let(:filter) { Search::Filter.new only: ['cost'] }

    it 'should remove cost' do
      filter.applier_for(hash).apply.keys.should_not include(:cost)
    end    

    it 'should not remove others' do
      filter.applier_for(hash).apply.keys.should include(:size, :rooms)
    end    
  end

  context 'except filter' do
    let(:filter) { Search::Filter.new except: ['cost'] }

    it 'should keep cost' do
      filter.applier_for(hash).apply.keys.should include(:cost)
    end

    it 'should remove all others' do
      filter.applier_for(hash).apply.keys.should_not include(:size, :rooms)
    end
  end
end