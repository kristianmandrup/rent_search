require 'spec_helper'

describe SearchManager do
  subject { search_manager }

  let(:search_manager) { SearchManager.new user }
  let(:user)           { create :agent_user }
  let(:search)         { create :valid_range_search  }

  its(:user)    { should == user }
  its(:history) { should be_a Property::Searcher::History }

  let(:history_item) {
    search.as_hash
  }

  describe 'store' do
    before do
      search_manager.store search
    end

    specify do
      search_manager.history.last.should == 
    end
  end
end