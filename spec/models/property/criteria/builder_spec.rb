require 'spec_helper'

describe Property::Criteria::Builder do
  subject { builder }

  let(:builder) { Property::Criteria::Builder.new criteria }

  let(:criteria) { Property::Criteria.new }

  describe '#where_criteria' do
  end

  [:string, :number, :boolean, :list, :range, :timespan].each do |type|
    specify do
      subject.send("#{type}_criteria").should_not be_nil
    end
  end

  describe '#criteria_types' do
    its(:criteria_types) { should == Property::Criteria.criteria_types }
  end

  describe '#criteria_fields_for' do
    specify { subject.send(:criteria_fields_for, :range).should_not be_empty }
  end

  describe '#skip_value?' do
    specify { subject.send(:skip_value?, :total_rent, 1000..2000).should == false }
    specify { subject.send(:skip_value?, :total_rent, 0..50000).should == true }
  end

  describe '#always_use_field?' do
    specify { subject.send(:always_use_field?, 'country_code').should == true }
    specify { subject.send(:always_use_field?, 'country').should == false }
  end

  describe '#real_field_name' do
    specify { subject.send(:criteria_field_name, :full_address).should == "position" }
    specify { subject.send(:criteria_field_name, :total_rent).should == 'costs.monthly.total' }
  end

  describe '#criteria_field_name' do
    specify { subject.send(:criteria_field_name, :full_address).should == "position" }
    specify { subject.send(:criteria_field_name, :total_rent).should == 'costs.monthly.total' }

    [:country_code].each do |name|
      specify { subject.send(:criteria_field_name, name).should == "address.#{name}" }
    end
  end
end