require 'spec_helper'

class SomeSearch
  include BasicDocument
  include BaseSearch::Sortable
end


describe 'BaseSearch::Sortable' do
  subject { sortable }

  let(:sortable) { SomeSearch.create }

  describe 'sort' do
    before do
      subject.sort = BaseSearch::Sort.create name: :date, direction: :asc
    end

    it 'has a sort' do
      expect(subject.sort).not_to be_nil
      expect(subject.sort).to be_a(BaseSearch::Sort)
    end
  end

  describe 'sorting' do  
    before do
      subject.sorting = 'asc::date'
    end

    it 'has a sorting' do
      expect(subject.sorting).to eq 'asc::date'
    end

    it 'has a sort' do
      expect(subject.sort).not_to be_nil
      expect(subject.sort).to be_a(BaseSearch::Sort)
    end

    it 'has create a sort from the sorting' do
      expect(subject.sort.name).to eq('created_at')
      expect(subject.sort.direction).to eq('asc')
    end
  end
end