require 'spec_helper'

describe Searcher::Sorter do
  subject { sorter }

  let(:sorter) do
    Searcher::Sorter.new :cost, :desc
  end

  describe 'init' do
    specify do
      subject.sort_order.should be_a BaseSearch::SortOrder
    end

    specify do
      subject.sort_order.field.should == :cost
    end

    specify do
      subject.sort_order.direction.should == :desc
    end
  end

  describe 'options_normalizer' do
    let(:sorter) do
      Searcher::Sorter.new :cost, :desc
    end

    specify do
      subject.options_normalizer.should be_a Searcher::Sort::OptionsNormalizer
    end
  end

  describe 'execute search_result' do
    let(:search_result) { Property.all }

    specify do
      subject.execute(search_result).should be_a Mongoid::Criteria
    end

    specify do
      subject.execute(search_result).options[:sort].should == {"cost"=>-1, "created_at"=>1}
    end
  end

  describe 'ordering' do
    specify do
      subject.ordering.should be_a Hash
    end

    specify do
      subject.ordering.should_not be_empty
    end

    specify do
      subject.ordering.should == {cost: :desc}.merge(sorter.default_order)
    end
  end

  describe 'selected_order' do
    specify do
      subject.selected_order.should == {cost: :desc}
    end
  end
end