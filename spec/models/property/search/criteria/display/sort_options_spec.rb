require 'spec_helper'

describe Property::SortOptions do
  subject { options }
  
  let(:options) { sort_options.options }

  before :all do
    I18n.default_locale = :en
  end

  describe 'default options' do
    let(:sort_options) { Property::SortOptions.new }

    describe 'defaults_for(:asc)' do
      specify do
        # puts "ascenders: #{sort_options.defaults_for(:asc)}"

        sort_options.defaults_for(:asc).should include(:cost)
        sort_options.defaults_for(:asc).should_not include(:rating)
      end
    end

    describe 'defaults_for(:desc)' do
      specify do
        # puts "descenders: #{sort_options.defaults_for(:desc)}"

        sort_options.defaults_for(:desc).should_not include(:cost)
        sort_options.defaults_for(:desc).should include(:rating)
      end
    end

    describe 'add_sort_field :desc, :cost' do
      let(:dir_labels) do
        {asc: 'cheapest', desc: 'costliest'}
      end

      specify do
        sort_options.add_sort_field(:desc, :cost, dir_labels).should be_nil
      end

      specify do
        sort_options.add_sort_field(:asc, :cost, dir_labels).should_not be_nil
      end
    end

    describe 'add_sort_field :date' do
      let(:dir_labels) do
        {asc: 'soonest'}
      end

      specify do
        sort_options.add_sort_field(:asc, :date, dir_labels).should_not be_nil
      end      

      specify do
        sort_options.add_sort_field(:desc, :date, dir_labels).should be_nil
      end      
    end

    specify do
      # puts subject.inspect
      subject.should be_an Array
      subject.first.should == ["soonest", "date::asc", {:class=>"ascending"}]
      subject.should include ["most rooms", "rooms::desc", {:class=>"descending"}]

      subject.should_not include(["costliest", "cost::desc", {:class=>"descending"}])
      subject.should include(["cheapest", "cost::asc", {:class=>"ascending"}])
    end
  end  

  describe 'options :cost ' do
    let(:sort_options) { Property::SortOptions.new :cost }

    specify do
      # puts subject
      subject.first.should == ["soonest", "date::asc", {:class=>"ascending"}]
      subject.should include ["most rooms", "rooms::desc", {:class=>"descending"}]

      subject.should include(["costliest", "cost::desc", {:class=>"descending"}])
      subject.should_not include(["cheapest", "cost::asc", {:class=>"ascending"}])
    end
  end  
end
