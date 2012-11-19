require 'spec_helper'

describe Property::Search::Agent do
  subject { agent }

  let(:agent) do
    Property::Search::Agent.create search: search
  end

  let(:search) do
    Property::Search.create cost: 1000..5000, rooms: 1..3 # fix size
  end

  specify do
    agent.search.should == search
  end
end
