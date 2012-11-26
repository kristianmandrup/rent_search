require 'spec_helper'

describe Property::Search::Criteria::Display::SortOptions do
  subject { sort_options }
  
  let(:clazz)             { Property::Search::Criteria::Display::SortOptions }
  
  let(:sort_order_class)  { Property::Search::SortOrder }
  let(:sort_order)        { sort_order_class.new :asc, :cost }
  
  let(:sort_options)      { clazz.new sort_order }

  before :all do
    I18n.default_locale = :en
  end

  describe 'selector_options' do
    let(:sort_order) { sort_order_class.new :asc, :date }

    subject { sort_options.selector_options }

    specify {
      sort_order.allow_any_field?.should be_false
    }

    # specify do
    #   sort_options.dir_calculator.sort_order.should == sort_order
    # end

    # specify do
    #   sort_options.dir_calculator.calc(:desc).should == :asc
    # end

    specify {
      sort_options.allow_any_field?.should be_false
    }

    specify do
      # puts subject
      subject.first.should == ["soonest", "date::asc", {:class=>"ascending"}]
      
      subject.should include ["most rooms", "rooms::desc", {:class=>"descending"}]

      subject.should include(["costliest", "cost::desc", {:class=>"descending"}])
      subject.should_not include(["cheapest", "cost::asc", {:class=>"ascending"}])
    end
  end  
end
