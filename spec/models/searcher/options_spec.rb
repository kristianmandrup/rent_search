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
    end

    describe 'create_default' do
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
