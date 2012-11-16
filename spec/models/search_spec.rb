require 'spec_helper'

class Search1 < ::Search
  field :cost
  field :size

  def self.all_fields
    %w{cost size}
  end
end

describe Search do
  subject { search }

  let(:search) { Search1.new }
  let(:search2) { Search1.new }

  describe 'agentized' do
    
  end

  context 'Empty search' do
    describe 'set_fields' do
      it 'should have no set fields' do
        search.set_fields.should be_empty
      end
    end

    describe 'subject_class' do
      specify do
        expect { search.subject_class }.to raise_error(NotImplementedError)
      end
    end

    describe 'eql?' do
      specify { subject.eql?(search).should be_true }
      specify { subject.eql?(search2).should be_false }
    end

    describe 'hash' do
      specify do
        expect { search.hash }.to raise_error(NotImplementedError)
      end
    end    
  end

  context 'Set search' do
    let(:search) { Search1.create cost: '5' }

    describe 'set_fields' do
      it 'should have no set fields' do
        search.set_fields.should == [:cost]
      end
    end    
  end
end
