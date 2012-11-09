require 'spec_helper'

describe Property::SearchOptions do
  subject { search_options }

  let(:search_options) { Property::SearchOptions.new }

  before :all do
    I18n.default_locale = :en
  end

  describe '.options name' do
    describe ':radius' do
      let(:radius) { subject.options(:radius) }

      specify do
        puts radius.hash_revert
        radius.should be_a Hash
      end
    end

    describe ':furnishment' do
      let(:furnishment) { subject.options(:furnishment) }

      specify do
        puts furnishment.hash_revert
        furnishment.should be_a Hash
        puts furnishment.inspect
        furnishment[:unfurnished].should_not be_blank
        furnishment[:furnished].should_not be_blank
      end
    end

    describe ':rooms' do
      let(:rooms) { subject.options(:rooms) }

      specify do
        puts rooms.hash_revert
        rooms.should be_a Hash
      end
    end

    describe ':type' do
      let(:type) { subject.options(:type) }

      specify do
        puts type.hash_revert
        type.should be_a Hash
        puts type.inspect
        type[:property].should_not be_blank
        type[:room].should_not be_blank
        type[:apartment].should_not be_blank
      end
    end

    describe ':size' do
      let(:size) { subject.options(:size) }

      specify do
        puts size.hash_revert
        puts size.inspect
        size.should be_a Hash
      end
    end

    describe ':rating' do
      let(:rating) { subject.options(:rating) }

      specify do
        puts rating.hash_revert
        rating.should be_a Hash
      end
    end

    describe ':rentability' do
      let(:rentability) { subject.options(:rentability) }

      specify do
        puts rentability.hash_revert
        rentability.should be_a Hash
      end
    end
  end
end