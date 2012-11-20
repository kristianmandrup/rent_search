require 'spec_helper'

describe Searcher::Options do
  subject { options }

  let(:options) do
    Searcher::Options.new
  end

  describe 'Constructors' do
    describe 'initialize (with symbols)' do
    end

    describe 'create_from' do
      let(:options) { Searcher::Options.create_from ordered: true, pager: false }

      its(:ordered) { should be_true }
      its(:paged)   { should be_false }
    end

    describe 'create_default' do
      let(:options) { Searcher::Options.create_default }

      its(:ordered) { should be_false }
      its(:paged)   { should be_false }
    end
  end

  describe 'paged' do
    context 'paged enabled' do
      let(:options) do
        Searcher::Options.new :paged
      end

      specify do
        options.paged.should be_true
      end
    end
  end

  describe 'ordered' do
    context 'ordered enabled' do
      let(:options) do
        Searcher::Options.new :ordered
      end

      specify do
        options.ordered.should be_true
      end
    end
  end

  describe 'enabled?' do
    context 'paged enabled' do
      let(:options) do
        Searcher::Options.new :paged
      end

      specify do
        options.send(:enabled?, :paged).should be_true
      end
    end
  end
end
