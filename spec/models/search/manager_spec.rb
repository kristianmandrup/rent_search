require 'spec_helper'

class FakeManager < Search::Manager
  def search_class
    Property::Search
  end
end

describe Search::Manager do
  subject { search_manager }

  let(:search_manager) { FakeManager.new user }
  let(:user)           { create :agent_user }
  let(:search)         { create :valid_property_search  }

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