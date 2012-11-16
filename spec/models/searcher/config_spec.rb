require 'spec_helper'

class SearcherConfig
  include Searcher::Config
end

describe Searcher::Config do
  subject { searcher }

  let(:searcher) do
    SearcherConfig.new
  end

  describe 'normalize_options' do
    context 'no args' do
      specify do
        subject.normalize_options.should be_a Searcher::Options
      end
    end

    context 'Hash' do
      context 'empty {}' do
        specify do
          subject.normalize_options({}).should be_a Searcher::Options
        end
      end

      context 'pager:true' do
        specify do
          subject.normalize_options(pager: true).should be_a Searcher::Options
        end

        specify do
          subject.normalize_options(pager: true).pager?.should be_true
        end
      end

      context 'pager:false' do
        specify do
          subject.normalize_options(pager: false).pager?.should be_false
        end
      end
    end

    context 'Array' do
      context 'empty []' do
        specify do
          subject.normalize_options([]).should be_a Searcher::Options
        end

        context ':pager' do
          specify do
            subject.normalize_options(:pager).pager?.should be_true
          end
        end
      end
    end
  end
end


