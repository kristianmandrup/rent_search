require 'spec_helper'

class SearchyAgent < BaseSearch
  def self.agent_class
    SearchyAgent
  end

  include_concern :agentize, for: 'BaseSearch'
end

class Searchick
  include BasicDocument

  belongs_to :agent, class_name: 'SearchyAgent'

  field :cost
  field :size
  field :rooms
end

describe Searchick do
  subject { search }

  let(:search) do
    Searchick.create cost: '7', size: 8, rooms: 1
  end

  describe 'creation' do
    specify { search.should be_a Searchick }
    its(:cost) { should == '7' }
    its(:size) { should == 8 }
  end  
end

describe BaseSearch::Agent do
  subject { agent }

  let(:agent) do
    SearchyAgent.create search: search
  end

  let(:search) do
    Searchick.create cost: '7', size: 8, rooms: 1
  end

  context 'has search' do
    specify do
      agent.search.should == search
    end

  #   describe 'to_search' do
  #     its(:to_search) { should == search }
  #   end

  #   its(:empty?) { should_not be_true }
  #   its(:valid?) { should be_true }
  end

  # context 'has no search' do
  #   specify do
  #     agent.search.should be_nil
  #   end

  #   its(:empty?) { should be_true }
  #   its(:valid?) { should be_false }
  # end
end