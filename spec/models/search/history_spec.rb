require 'spec_helper'

class BaseSearch
  def self.all_fields
    %w{cost size rooms}
  end

  # as implemented in Property::Search
  def hash
    self.class.all_fields.inject(0) {|res, f| res += send(f).hash }
  end    

  all_fields.each do |f|
    field f
  end
end

describe BaseSearch::History do
  subject { history }

  let(:history) do
    BaseSearch::History.new
  end

  let(:search) do
    BaseSearch.create cost: '7', size: 8, rooms: 1
  end

  let(:search_dup) do
    BaseSearch.create cost: '7', size: 8, rooms: 1
  end

  let(:search2) do
    BaseSearch.create cost: '2', size: 3, rooms: 2
  end

  specify do
    history.max_size.should == 10
  end

  describe 'push' do
    before do
      history.push(search)
    end

    specify do
      history.current_size.should == 1
      history.last.should == search
    end
  end

  describe 'all' do
    before do
      history.push(search)
      history.push(search2)
    end

    specify do
      history.current_size.should == 2
      history.all(:filled).should == [search, search2]
    end
  end

  describe 'empty?' do
    context'has NO items' do
      specify do
        history.empty?.should be_true
      end
    end

    context'has items' do
      before :each do
        history.push(search)
      end

      specify do
        history.empty?.should be_false
      end
    end
  end

  describe 'last' do
    context'has NO items' do
      specify do
        history.last.should be_nil
      end
    end

    context'has 1 item' do
      before :each do
        history.push(search)
      end

      specify do
        history.last.should == search
      end      
    end    
  end


  describe 'full?' do
    context'has NO items' do
      specify do
        history.full?.should be_false
      end
    end

    context'has 1 item' do
      before :each do
        history.push(search)
      end

      specify do
        history.full?.should be_false
      end
    end

    context'duplicate search' do
      specify do
        search.hash.should_not be_nil
      end

      specify do
        search.hash.should == search_dup.hash
      end
    end

    context'has 10 duplicate items' do
      before :each do
        # TODO: Allow duplicates?
        5.times do
          history.push search
          history.push search_dup
        end
      end

      specify do
        history.current_size.should == 1
      end
    end
  end
end