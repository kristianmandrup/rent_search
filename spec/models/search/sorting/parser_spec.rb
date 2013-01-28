require 'spec_helper'

describe BaseSearch::Sorting::Parser do
  subject { parser }

  let(:clazz) { BaseSearch::Sorting::Parser }

  describe 'init' do
    let(:parser) { clazz.new 'cost::asc' }

    its(:parse) { should be_a Hash }
    its(:parse) { should == {field: 'cost', direction: 'asc' } }
  end
end

