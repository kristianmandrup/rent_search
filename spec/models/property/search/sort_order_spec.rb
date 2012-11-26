require 'spec_helper'

describe Property::Search::SortOrder do
  subject { sort_order }

  context 'default' do
    let(:sort_order) { Property::Search::SortOrder.new }

    its(:field)     { should == :published_at }
    its(:name)      { should == :date }
    its(:direction) { should == :asc }

    its(:default_options)   { should == {field: :date, direction: :asc} }
  end
end


