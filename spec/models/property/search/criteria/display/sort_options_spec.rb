require 'spec_helper'

describe Property::Search::Criteria::Display::SortOptions do
  subject { sort_options }
  
  let(:clazz)             { Property::Search::Criteria::Display::SortOptions }
  
  let(:sort_order_class)  { Property::Search::SortOrder }
  let(:sort_order)        { sort_order_class.new :asc, :cost }

  describe 'default init' do
    let(:sort_options) { clazz.new }

    its(:sort_order) { should be_a Property::Search::SortOrder }

    specify { subject.sort_order.direction.should == :asc }
    specify { subject.sort_order.name.should  == :date }
    specify { subject.sort_order.field.should == :published_at }
  end
  
  let(:sort_options)      { clazz.new sort_order }

  before :all do
    I18n.default_locale = :en
  end

  describe 'selector_options' do
    let(:sort_order) { sort_order_class.new :asc, :date }
    
    specify {
      sort_order.allow_any_field?.should be_false
    }

    specify {
      sort_options.allow_any_field?.should be_false
    }

    specify do
      sort_order.reverse!.direction.should == :asc
    end

    specify do
      # puts subject
      subject.selector_options.should == sort_options.options
    end

    specify do
      # puts subject
      subject.selector_options.first.should == ["soonest", "date::asc", {:class=>"ascending"}]
    end

    its(:selector_options) { should include ["less rooms", "rooms::asc", {:class=>"ascending"}] }
    its(:selector_options) { should include ["cheapest", "cost::asc", {:class=>"ascending"}] }

    its(:selector_options) { should_not include ["costliest", "cost::desc", {:class=>"descending"}] }  
  end  

  describe 'sorted by cost asc' do
    let(:sort_order) { sort_order_class.new :cost, :asc }

    describe 'should not include cost:asc as a choice since already chosen' do
      its(:selector_options) { should_not include ["cheapest", "cost::asc", {:class=>"ascending"}] }
      its(:selector_options) { should include ["costliest", "cost::desc", {:class=>"descending"}] } 
    end 
  end    
end
