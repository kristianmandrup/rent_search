require 'spec_helper'

describe Property::Search::Criteria::Display::SortOptions::Calculator do
  subject { calculator }

  let(:clazz)             { Property::Search::Criteria::Display::SortOptions::Calculator }
  let(:sort_order_class)  { Property::Search::SortOrder }
  
  let(:sort_order)        { sort_order_class.new :rentability, :asc }

  let(:calculator) { clazz.new(sort_order, option) }

  # as READ from yml file
  let(:option) { ['rentability', {asc: 'best chance'}] }

  describe 'init' do
    context 'first arg is not a sort order' do
      it 'must take a sort order' do
        expect { clazz.new 'hello' }.to raise_error(ArgumentError)
      end
    end

    context 'first arg is a sort order' do
      it 'must also take option arg' do
        expect { clazz.new sort_order }.to raise_error(ArgumentError)
      end
    end

    context 'first arg is a sort order and second is a string' do
      let(:option) { 'hello '}

      it 'option arg must be an Array' do
        expect { clazz.new sort_order, option }.to raise_error(ArgumentError)
      end
    end

    context 'first arg is a sort order and second is an Array of Strings' do
      let(:option) { ['hello', 'you'] }

      it 'option arg Array must include a Hash as last arg' do
        expect { clazz.new sort_order, option }.to raise_error(ArgumentError)
      end
    end

    context 'first arg is a sort order and second is a valid option Array' do
      specify do
        expect { clazz.new sort_order, option }.to_not raise_error(ArgumentError)
        puts calculator.inspect
      end

      its(:sort_order)  { should == sort_order }        
      its(:name)        { should == option.first }
      its(:dir_labels)  { should == option.last }
      its(:field_name)  { should == sort_order.field_name(option.first) }
    end
  end

  specify do
    subject.sort_order.desc_fields.should_not be_empty
  end

  specify do
    subject.sort_order.asc_fields.should_not be_empty
  end

  context 'sort_order :rentability, :asc' do
    let(:option) { ['rentability', {asc: 'best chance'}] }
    let(:sort_order) { Property::Search::SortOrder.new :rentability, :asc }

    its(:name)                  { should == "rentability" }
    its(:sort_order_name)       { should == "rentability" }

    # because: name != sort_order_name
    its(:matching_sort_order?)  { should be_true }

    its(:select_option)         { should be_an Array }
    its(:select_option)         { should == ["best chance", "rentability::asc", {:class=>"ascending"}] }
    its(:option_value)          { should == "rentability::asc" }

    # bacause: matching_sort_order? is true
    its(:reverse_direction?)    { should be_false }

    # because: matching_sort_order? is true
    its(:chosen_direction)      { should == :asc }
  end

  its(:reverse_chosen_direction) { should == :desc  }
  
  its(:chosen_direction) { should == :asc  }

  describe 'select_field?' do
    its(:select_field?) { should be_false  }
  end  

  # what is this?
  describe 'default_dir_label?' do
    its(:default_dir_label?) { should == false  }
  end

  describe 'direction_labels' do
    its(:direction_labels) { should == [:date, :rentability, :cost, :cost_m2, :size, :rooms] }
  end   

  context 'date desc' do
    let(:sort_order)        { sort_order_class.new :date, :desc } 

    let(:option) { ['date', {asc: 'soonest'}] }

    describe 'should only allow direction :asc' do
      its(:name)                  { should == "date" }
      its(:sort_order_name)       { should == "date" }

      # because: name != sort_order_name
      its(:matching_sort_order?)  { should be_true }

      its(:select_option)         { should be_an Array }
      its(:select_option)         { should == ['soonest', 'date::asc', {:'class' => "ascending"}] }
      its(:option_value)          { should == "date::asc" }

      # bacause: matching_sort_order? is true
      its(:reverse_direction?)    { should be_true }

      # because: matching_sort_order? is true
      its(:chosen_direction)      { should == :desc }      
    end
  end

  context 'date asc' do
    let(:sort_order)        { sort_order_class.new :date, :asc } 

    let(:option) { ['date', {asc: 'soonest'}] }


    specify do
      subject.sort_order.desc_fields.should_not include :date
    end

    specify do
      subject.sort_order.asc_fields.should include :date
    end

    describe 'should only allow direction :asc' do
      its(:name)                  { should == "date" }
      its(:sort_order_name)       { should == "date" }

      # because: name != sort_order_name
      its(:matching_sort_order?)  { should be_true }

      its(:select_option)         { should be_an Array }
      its(:select_option)         { should == ['soonest', 'date::asc', {:'class' => "ascending"}] }
      its(:option_value)          { should == "date::asc" }

      # bacause: matching_sort_order? is true
      its(:reverse_direction?)    { should be_false }

      # because: matching_sort_order? is true
      its(:chosen_direction)      { should == :asc }      
    end
  end

end