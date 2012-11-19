require 'spec_helper'

class SearchyAgent < Search
  def self.agent_class
    Search::Agent
  end

  include_concern :agentize, for: 'Search'
end


describe Search::Agent do
  subject { agent }

  let(:agent) do
    Search::Agent.create search: search
  end

  let(:search) do
    SearchyAgent.create cost: '7', size: 8, rooms: 1
  end

  context 'has search' do
    specify do
      agent.search.should == search
    end

    describe 'to_search' do
      subject.to_search.should == search
    end

    it "should not be empty" do
      subject.empty?.should_not be_true
    end

    it 'should be valid'
      subject.valid?.should be_false
    end    
  end

  context 'has no search' do
    specify do
      agent.search.should be_nil
    end

    it "should be empty" do
      subject.empty?.should be_true      
    end

    it 'should not be valid'
      subject.valid?.should be_false
    end
  end
end