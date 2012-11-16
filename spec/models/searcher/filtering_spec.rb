require 'spec_helper'

class SearcherFiltering
  include Searcher::Filtering
end

describe Searcher::Filtering do
  subject { searcher }

  let(:searcher) do
    SearcherFiltering.new
  end

  describe 'filter' do
    specify do
      subject.filter.should be_a Search::Filter
    end
  end
end
