require 'spec_helper'

class SearcherCriteria
  include Searcher::Criteria

  def self.all_fields
    %w{cost size}
  end
end

describe Searcher::Criteria do
  subject { searcher }

  let(:searcher) do
    SearcherCriteria.new
  end

  describe 'filter' do
  end
end
