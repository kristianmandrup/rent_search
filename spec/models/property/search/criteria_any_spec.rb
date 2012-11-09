require 'spec_helper'
# require 'timespan/mongoid'

describe Property::Criteria do

  let(:clazz) { Property::Criteria }

  describe 'set fields to any' do
    def criteria
      @any_criteria ||= clazz.create  type:       'any',        furnishment:  'any', 
                                      rooms:      'any',        size:         'any', 
                                      total_rent: 'any',        period:       'any',
                                      radius:     'any',        full_address: ''
    end

    specify do
      subject.send(:string_criteria).should == {"address.country_code" => 'DK'}
    end

    specify do
      subject.send(:number_criteria).should == {}
    end

    specify do
      subject.send(:range_criteria).should == {}
    end

    specify do
      subject.send(:list_criteria).should == {}
    end

    specify do
      subject.send(:timespan_criteria).should == {}
    end
  end
end