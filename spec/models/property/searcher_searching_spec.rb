require 'spec_helper'

describe Property::Searcher do
  subject { searcher }

  let(:clazz) { Property::Searcher }

  let(:valid_options) do 
    {paged: true, ordered: true}
  end

  context 'valid searcher: paging and sorting on' do
    let(:searcher) { clazz.new valid_options }

    context 'Searching' do
      specify do
        subject.paged?.should be_true
      end

      describe 'search' do
        specify do
          subject.search.should be_a searcher.search_class
        end
      end  

      describe 'search_result' do
        let(:result) { searcher.execute }

        specify do
          # puts result.inspect
          subject.search_result.should be_a Mongoid::Criteria
        end

        specify do
          result.inspect.should match /class:\s+Property/
        end

        specify do
          result.options.should == {:limit=>20, :skip=>0}
        end
      end

      describe 'paged' do
        specify do
          puts subject.paged.inspect
          subject.paged.should be_a Mongoid::Criteria
        end
      end

      describe 'execute' do
        specify do
          puts subject.execute.inspect
          subject.execute.should be_a Mongoid::Criteria
        end

        specify do
          # puts subject.execute.inspect
          subject.execute.should == subject.paged(subject.ordered)
        end

        context 'page 2 padding 5, sorted :cost ascending' do
          let(:searcher) { clazz.new(valid_options).display(page: 2, padding: 5).sorted_by(:cost, :asc) }

          specify do
            subject.pager.page.should == 2
          end

          specify do
            subject.pager.padding.should == 5
          end

          specify do
            subject.sorter.field.should == :cost
          end

          specify do
            subject.sorter.direction.should == :asc
          end
        end
      end    
    end
  end
end