require 'spec_helper'

class SearchWithHasher
  include_concern BaseSearch::Hasher, for: ''

  def subject_class
    self.class
  end
  
  def self.all_fields
    %w{cost size}
  end
end

describe BaseSearch::Hasher do
  subject { hasher }

  let(:hasher) { SearchWithHasher.new }

  before do
    hasher.stub(:cost => 7)
    hasher.stub(:size => 2)
  end

  describe '.as_hash' do
    describe 'default' do
      specify {
        hasher.as_hash.should == {"cost" => 7, "size" => 2}
      }
    end

    describe ':symbol' do
      specify {
        hasher.as_hash(:symbol).should == {cost: 7, size: 2}
      }
    end
  end

  describe 'hash_for' do
    describe 'default' do
      specify {
        hasher.send(:hash_for, :cost).should == {"cost" => 7}
      }
    end

    describe ':symbol' do
      specify {
        hasher.send(:hash_for, :cost, :symbol).should == {cost: 7}
      }
    end    
  end
end