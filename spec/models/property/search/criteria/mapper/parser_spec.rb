require 'spec_helper'

describe Property::Search::Criteria::Mapper::Parser do
  subject     { normalizer }

  let(:clazz) { Property::Search::Criteria::Mapper::Parser }

  describe 'range_arr' do
    context '50-100' do
      subject { clazz.new "50-100" }
      its(:range_arr) { should == [50, 100] }
    end

    context '+50' do
      subject { clazz.new "+50" }
      its(:range_arr) { should == [50, 900000000] }
      its(:more_or_eq_expr?) { should be_true }
    end

    context '50+' do
      subject { clazz.new "50+" }
      its(:range_arr) { should == [50, 900000000] }
      its(:more_or_eq_expr?) { should be_true }
    end

    context '50-' do
      subject { clazz.new "50-" }
      its(:range_arr) { should == [0, 50] }
      its(:less_or_eq_expr?) { should be_true }
    end

    context 'less than 50' do
      subject { clazz.new "less than 50" }
      its(:range_arr) { should == [0, 49] }
      its(:less_expr?) { should be_true }
    end

    context 'more than 50' do
      subject { clazz.new "more than 50" }
      its(:range_arr) { should == [51, 900000000] }
      its(:more_expr?) { should be_true }
    end

    context '50 or less' do
      subject { clazz.new "50 or less" }
      its(:range_arr) { should == [0, 50] }
      its(:less_or_eq_expr?) { should be_true }
    end

    context '50 or more' do
      subject { clazz.new "50 or more" }
      its(:range_arr) { should == [50, 900000000] }
      its(:more_or_eq_expr?) { should be_true }
    end
  end
end