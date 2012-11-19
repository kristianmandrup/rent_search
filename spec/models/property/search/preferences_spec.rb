require 'spec_helper'

describe Property::Search::Preferences do
  subject { preferences }

  let(:preferences) { Property::Search::Preferences.new area_unit: 'sqm', currency: 'EUR' }

  context 'defaults' do
    let(:preferences) { Property::Search::Preferences.new }

    specify do
      subject.area_unit.should == preferences.send(:default_area_unit)
      subject.currency.should == preferences.send(:default_currency)
    end
  end

  specify do
    subject.should be_a Property::Search::Preferences
  end

  it 'should have an area_unit' do
    subject.area_unit.should == 'sqm'
  end

  it 'should have a currency' do
    subject.currency.should == 'EUR'
  end

  describe 'area_unit=' do
    it 'should set currency' do
      Property::Search::Preferences.new(area_unit: 'sqfeet').area_unit.should == 'sqfeet'
    end
  end

  describe 'currency=' do
    it 'should set currency' do
      Property::Search::Preferences.new(currency: 'DKK').currency.should == 'DKK'
    end
  end

  context 'validations' do
    describe 'area_unit=' do
      it 'should raise error on invalid area unit' do
        expect { Property::Search::Preferences.new area_unit: 'abc' }.to raise_error
      end
    end

    describe 'currency=' do
      it 'should raise error on invalid currency' do
        expect { Property::Search::Preferences.new currency: 'abc' }.to raise_error
      end
    end
  end
end
