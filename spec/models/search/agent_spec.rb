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

  specify do
    agent.search.should == search
  end
end
