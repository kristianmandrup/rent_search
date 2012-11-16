require 'spec_helper'

describe Searcher do
  subject { searcher }

  let(:searcher)      { Searcher.new }
  let(:valid_options) do 
    {paged: true, ordered: true}
  end

  describe 'init' do
    context 'no args' do
      let(:searcher) { Searcher.new }

      it 'should have no options' do
        searcher.searcher_options.should be_empty
      end
    end

    context 'with invalid searcher_options' do
      specify do 
        expect { Searcher.new a: 1 }.to raise_error(ArgumentError)
      end
    end

    context 'with valid searcher_options' do
      let(:searcher) { Searcher.new valid_options }

      it 'should not have searcher options' do
        searcher.searcher_options.should_not be_empty
      end
    end
  end

  describe 'find criteria' do
    it 'should find those matching criteria' do
      searcher.find(criteria).should_not be_empty
    end
  end
end
