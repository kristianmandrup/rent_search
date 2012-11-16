require 'spec_helper'

class SearcherFiltering
  include Searcher::Filtering

  def self.all_fields
    %w{cost size}
  end
end

describe Searcher::Filtering do
  subject { searcher }

  let(:searcher) do
    SearcherFiltering.new
  end

  describe 'filter' do
  end
end
