require 'spec_helper'

describe Searcher::Pager do
  subject { pager }

  let(:pager) do
    Searcher::Pager.new page: 1
  end

  let(:search_result) do
    Search.new.execute # default search method?
  end

  describe 'page' do
    context 'no page' do
      let(:pager) do
        Searcher::Pager.new
      end

      specify do
        pager.page.should == 1
      end      
    end

    context 'page 2' do
      let(:pager) do
        Searcher::Pager.new page: 2
      end

      specify do
        pager.page.should == 2
      end      
    end
  end

  describe 'execute search_result' do
    specify do
      pager.execute(search_result).should be_a Mongoid::Criteria
    end
  end
end

