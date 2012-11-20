require 'spec_helper'

describe Property::Search::Criteria::Mapper::Converter do
  subject     { converter }

  let(:clazz) { Property::Search::Criteria::Mapper::Converter }

  context "1,2 eller 4" do
    let(:converter) { clazz.new "1,2 eller 4" }

    its(:convert) { should == [1, 2, 4] }
  end

  context "1 eller 4" do
    let(:converter) { clazz.new "1 eller 4" }

    its(:convert) { should == [1, 4] }
  end
end