require 'spec_helper'

class SearcherSorting
  attr_reader :options

  include Searcher::Config

  include Searcher::Sorting

  def initialize options = {}
    @options = normalize_options options    
  end

  def self.all_fields
    %w{cost size}
  end
end

class Calculator1 < ::BaseSearch::SortOrder::Calculator
  def asc_fields
    %w{cost size}
  end
end

describe Searcher::Sorting do
  subject { searcher }

  let(:searcher) do
    SearcherSorting.new(:sorter).sorted_by(field: :cost).sort_order_calculator(Calculator1)
  end

  describe 'sorter' do
    specify do
      subject.sorter.should be_a Searcher::Sorter
    end
  end

  describe 'sort_options' do
    context 'no options' do
      let(:searcher) do
        SearcherSorting.new(:sorter).sort_order_calculator(Calculator1)
      end

      specify do
        subject.sorter_options.should == {}
      end
    end

    context 'valid sort by options' do
      let(:searcher) do
        SearcherSorting.new(:sorter).sorted_by(field: :cost).sort_order_calculator(Calculator1)
      end

      specify do
        subject.sorter_options.should == {field: :cost}
      end
    end
  end

  describe 'sorted(result)' do
    specify do
      # subject.paged(result)
    end
  end

  describe 'sorted?' do
    let(:searcher) do
      SearcherSorting.new(:sorter).sort_order_calculator(Calculator1)
    end

    specify do
      subject.sorted?.should be_true
    end
  end
end
