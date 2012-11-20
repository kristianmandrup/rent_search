require 'spec_helper'

describe Searcher do
  subject { searcher }

  let(:searcher)  { Searcher.new }

  let(:valid_options) do 
    {paged: true, ordered: true}
  end

  describe 'init' do
    context 'no args' do
      let(:searcher) { Searcher.new }

      it 'should have no options' do
        searcher.options.should be_empty
      end
    end

    context 'with invalid searcher_options' do
      specify do 
        expect { Searcher.new 'my search' }.to raise_error(ArgumentError)
      end
    end

    context 'with valid searcher_options' do
      let(:searcher) { Searcher.new valid_options }

      it 'should not have searcher options' do
        searcher.options.should_not be_empty
      end
    end
  end

  describe 'find criteria' do
    let(:criteria) do
      {}
    end

    it 'should set criteria used by searcher' do
      searcher.find(criteria).criteria.should == criteria
    end
  end

  describe 'only *filter_list' do
    describe 'remove only' do
      let(:keys) do
        subject.find(size: 40..60, rooms: 1..3).remove_only(:rooms).filtered_criteria.keys
      end

      it 'should keep only the listed criteria by setting the criteria filter' do
        keys.should == [:size]
      end
    end

    describe 'keep only' do
      let(:keys) do
        subject.find(size: 40..60, rooms: 1..3).keep_only(:rooms).filtered_criteria.keys
      end

      it 'should keep only the listed criteria by setting the criteria filter' do
        keys.should == [:rooms]
      end
    end
  end

  describe 'except *filter_list' do
    describe 'remove all except' do
      let(:keys) do
        subject.find(size: 40..60, rooms: 1..3).remove_all_except(:rooms).filtered_criteria.keys
      end
      
      it 'should keep all criteria except those listed, by setting the criteria filter' do
        keys.should == [:rooms]
      end
    end

    describe 'keep all except' do
      let(:keys) do
        subject.find(size: 40..60, rooms: 1..3).keep_all_except(:rooms).filtered_criteria.keys
      end
      
      it 'should keep all criteria except those listed, by setting the criteria filter' do
        keys.should == [:size]
      end    
    end
  end

  # Must be implemented by sublclass
  # describe 'search_builder' do
  #   its(:search_builder) { should be_a searcher.search_builder_class }

  #   specify do
  #     subject.search_builder.criteria.should == searcher.filtered_criteria
  #   end

  #   specify do
  #     subject.search_builder.preferences.should == searcher.preferences
  #   end
  # end  

  describe 'search' do
    pending
  end  

  describe 'search_result' do
    pending
  end

  describe 'execute' do
    pending
  end
end
