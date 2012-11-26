require 'spec_helper'

describe Property::Search::Criteria::Mapper::Converter do
  subject     { converter }

  let(:clazz) { Property::Search::Criteria::Mapper::Converter }

  context 'text with spaces (untrimmed)' do
    context 'locale :en' do 
      before do
        I18n.default_locale = :en
      end

      context " 1,2 or 4 " do
        let(:converter) { clazz.new " 1,2 or 4 " }

        its(:convert) { should == [1, 2, 4] }
      end

      context " 1 or 4 " do
        let(:converter) { clazz.new " 1 or 4 " }

        its(:convert) { should == [1, 4] }
      end
    end

    context " 1 " do
      let(:converter) { clazz.new " 1 " }

      its(:convert) { should == [1, 1] }
    end  
  end
end