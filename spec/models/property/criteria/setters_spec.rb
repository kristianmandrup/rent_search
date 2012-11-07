require 'spec_helper'

class SettersDoc
  include BasicDocument

  include Property::Criteria::Fields
  include Property::Criteria::Setters
end

describe Property::Criteria::Setters do

  let(:clazz) { SettersDoc }

  def default name
    clazz.criteria_default name
  end

  describe 'defaults' do
    specify { default(:country_code).should == 'DK' }
    specify { default(:rooms).should == (1..12) }
    specify { default(:size).should == (0..1000) }
    specify { default(:total_rent).should == (0..50000) }
    specify { default(:radius).should == 50 }
  end

  # describe 'shared=' do
  #   subject { clazz.create shared: 'any' }

  #   its(:shared)       { should == default(:shared }
  # end

  describe 'rooms=' do
    subject { clazz.create rooms: 'any' }

    its(:rooms)       { should == default(:rooms) }
  end

  describe 'size=' do
    subject { clazz.create size: 'any' }  

    its(:size)        { should == default(:size) }
  end

  describe 'total_rent=' do
    subject { clazz.create total_rent: 'any' }  

    its(:total_rent)  { should == default(:total_rent) }
  end

  describe 'radius=' do
    subject { clazz.create radius: 'any' }  

    its(:radius)  { should == default(:radius) }
  end

  describe 'type=' do
    subject { clazz.create type: 'any' }  

    its(:type)  { should == 'any' }
  end

  describe 'furnishment=' do
    subject { clazz.create furnishment: 'any' }  

    its(:furnishment)  { should == 'any' }
  end

  subject { criteria }

  describe 'default field values' do
    let(:criteria)  do
      clazz.create
    end

    SettersDoc.search_fields.each do |field|
      its(field) { should == default(field) }
    end
  end

  describe 'set fields to any' do
    def criteria
      @any_criteria ||= clazz.create  type:       'any',        furnishment:  'any', 
                                      rooms:      'any',        size:         'any', 
                                      total_rent: 'any',        period:       'any',
                                      radius:     'any',        full_address: '',
                                      shared:     'any'
    end

    SettersDoc.search_fields.each do |field|
      its(field) { should == default(field) }
    end
  end

  describe 'country_code' do
    context 'US' do
      let(:criteria) do
        clazz.create country_code: 'US'
      end

      its(:country_code) { should == 'DK' }
    end

    context 'DK' do
      let(:criteria) do
        clazz.create country_code: 'DK'
      end

      its(:country_code) { should == 'DK' }
    end    

    context 'SE' do
      let(:criteria) do
        clazz.create country_code: 'SE'
      end

      its(:country_code) { should == 'SE' }
    end    
  end  
end