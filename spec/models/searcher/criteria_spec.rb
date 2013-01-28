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

  describe 'criteria' do
    its(:criteria) do 
      should == {}
    end
  end

  describe 'criteria_builder' do
    its(:criteria_builder) { should be_a BaseSearch::Criteria }

    specify do
      subject.criteria_builder.options.should == {}
    end
  end

  describe 'criteria_class' do
    its(:criteria_class) { should == BaseSearch::Criteria }
  end

  describe 'filtered_criteria' do
    pending 'TODO ?'
  end
end