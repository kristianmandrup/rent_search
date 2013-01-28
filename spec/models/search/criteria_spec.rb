require 'spec_helper'

class SearchCriteria < BaseSearch::Criteria
  include BasicDocument

  def initialize options = {}
    puts "opts: #{options}"
    super
  end
end

describe BaseSearch::Criteria do
  subject { criteria }

  let(:options) do
    {cost: 1}
  end

  let(:criteria) { SearchCriteria.new options }

  # its(:options) { should == options }

  describe 'builder' do
    it 'should not have a builder' do
      expect { subject.builder }.to raise_error
    end
  end
end
