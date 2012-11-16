require 'spec_helper'

class SearcherPaging
  attr_reader :options

  include Searcher::Config

  include Searcher::Paging

  def initialize options = {}
    @options = normalize_options options    
  end

  def self.all_fields
    %w{cost size}
  end
end

describe Searcher::Paging do
  subject { searcher }

  let(:searcher) do
    SearcherPaging.new
  end

  describe 'pager' do
    specify do
      subject.pager.should be_a Searcher::Pager
    end
  end

  describe 'pager_options' do
    let(:searcher) do
      SearcherPaging.new(:pager).display(page:1)
    end

    specify do
      subject.pager_options.should == {}
    end
  end

  describe 'paged(result)' do
    specify do
      # subject.paged(result)
    end
  end

  describe 'paged?' do
    let(:searcher) do
      SearcherPaging.new :pager
    end

    specify do
      subject.paged?.should be_true
    end
  end
end
