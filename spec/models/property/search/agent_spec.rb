require 'spec_helper'

describe Property::Search::Agent do
  subject { agent }

  let(:agent) do
    Property::Search::Agent.create search: search
  end

  let(:search) do
    Property::Search.create cost: '7', size: 8, rooms: 1
  end

  specify do
    agent.search.should == search
  end
end
