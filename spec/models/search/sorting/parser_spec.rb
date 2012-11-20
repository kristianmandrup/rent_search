require 'spec_helper'

describe Search::Sorting::Parser do
  subject { parser }

  let(:clazz) { Search::Sorting::Parser }

  describe 'init' do
    let(:parser) { clazz.new 'cost::asc' }

    its(:parse) { should be_a Hash }
    its(:parse) { should == {field: 'cost', direction: 'asc' } }
  end
end

