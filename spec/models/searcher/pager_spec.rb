require 'spec_helper'

describe Searcher::Pager do
  subject { pager }

  let(:pager) do
    Searcher::Pager.new page: 1
  end

  let(:search_result) do
    Property.all # default search method?
  end

  describe 'page' do
    context 'no page' do
      let(:pager) do
        Searcher::Pager.new
      end

      specify do
        subject.page.should == 1
      end
    end

    context 'page 2' do
      let(:pager) do
        Searcher::Pager.new page: 2
      end

      specify do
        subject.page.should == 2
      end
    end
  end

  describe 'execute search_result' do
    specify do
      subject.execute(search_result).should be_a Mongoid::Criteria
    end

    specify do
      puts subject.execute(search_result).inspect
      subject.execute(search_result).options[:limit].should > 0
    end

    specify do
      subject.execute(search_result).options[:skip].should >= 0      
    end
  end
end