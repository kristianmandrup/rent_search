require 'spec_helper'

describe Hash::KeyFilter do
  subject { result }

  describe 'reject_keys' do
    let(:result) { @hash.reject_keys(:cost) }

    before do
      @hash = {cost: '7', size: 8, rooms: 1}
    end

    specify { subject.should_not == @hash }
    specify { subject.should_not include(:cost) }
    specify { subject.should include(:size) }
  end

  describe 'delete_keys' do
    let(:result) { @hash.delete_keys(:cost) }

    before do
      @hash = {cost: '7', size: 8, rooms: 1}
    end

    specify { subject.should == @hash }
    specify { subject.should_not include(:cost) }
    specify { subject.should include(:size) }
  end


  describe 'keep_keys!' do
    let(:result) { @hash.keep_keys!(:cost) }

    before do
      @hash = {cost: '7', size: 8, rooms: 1}
    end

    specify { subject.should == @hash }
    specify { subject.should include(:cost) }
    specify { subject.should_not include(:size) }

    context 'no args' do
      let(:result) { @hash.keep_keys! }

      before do
        @hash = {cost: '7', size: 8, rooms: 1}
      end

      specify { subject.should == @hash }
    end    
  end

  describe 'keep_keys' do
    let(:result) { @hash.keep_keys(:cost) }

    before do
      @hash = {cost: '7', size: 8, rooms: 1}
    end

    specify { subject.should_not == @hash }
    specify { subject.should include(:cost) }
    specify { subject.should_not include(:size) }

    context 'no args' do
      let(:result) { @hash.keep_keys }

      before do
        @hash = {cost: '7', size: 8, rooms: 1}
      end

      specify { subject.should == @hash }
    end
  end
end