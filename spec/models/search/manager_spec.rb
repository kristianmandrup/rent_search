require 'spec_helper'

describe Search::Manager do
  subject { search_manager }

  let(:search_manager) { Search::Manager.new user }
  let(:user)           { create :agent_user }
  let(:search)         { create :search  }

  its(:user)    { should == user }
  its(:history) { should be_a Search::History }

  let(:history_item) {
    search.as_hash
  }

  describe 'store' do
    before do
      search_manager.store search
    end

    specify do
      subject.history.last.should == history_item
    end
  end
end