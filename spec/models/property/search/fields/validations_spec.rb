require 'spec_helper'

class ValidationsDoc
  include BasicDocument

  include Property::Search::Fields::TypeMapping
  include Property::Search::Fields::Validations
end

describe Property::Search::Fields::Validations do
  let(:clazz) { ValidationsDoc }

  describe 'validations' do
    describe 'shared=' do
      subject { clazz.create shared: 1}

      its(:valid?) { should be_true }
    end

    describe 'types=' do
      context 'valid types' do
        subject { clazz.create types: ['room', 'apartment'] }

        before do
          puts subject.errors.inspect
        end

        its(:valid?) { should be_true }
      end

      context 'invalid type' do
        subject { clazz.create types: ['room', 'invalid'] }

        its(:valid?) { should be_false }
      end
    end

    # should set and validate on sqm or sqfeet depending on Preferences !!!
    describe 'size=' do
      pending 'TODO'
    #   context 'size < 5' do
    #     subject { clazz.create size: (1..20) }

    #     its(:valid?) { should be_false }
    #   end      

    #   context 'size > 300' do
    #     subject { clazz.create size: (50..400) }
        
    #     its(:valid?) { should be_false }
    #   end
    end

    # # Allow Array
    describe 'rooms=' do
      context 'rooms 2..3' do
        subject { clazz.create rooms: [2,3] }
        
        its(:valid?) { should be_true }
      end

      context 'rooms 7' do
        subject { clazz.create rooms: [1,2,7] }
        
        its(:valid?) { should be_true }
      end

      context 'rooms 0' do
        subject { clazz.create rooms: [0] }
        
        its(:valid?) { should be_false }
      end

      context 'rooms 13' do
        subject { clazz.create rooms: [13] }
        
        its(:valid?) { should be_false }
      end
    end

    describe 'period=' do
      let(:valid_period)  { Timespan.new start_date: 1.day.ago, duration: 5.days }
      let(:old_period)    { Timespan.new start_date: 4.months.ago, duration: 5.days }
      let(:future_period) { Timespan.new start_date: 3.years.from_now, duration: 5.days }

      context 'should allow period 1 day ago' do
        subject { clazz.create period: valid_period }

        its(:valid?) { should be_true }
      end

      context 'should not allow period 4 months ago' do
        subject { clazz.create period: old_period }

        its(:valid?) { should be_false }
      end

      context 'should not allow period 3 years from now' do
        subject { clazz.create period: future_period }

        its(:valid?) { should be_false }
      end
    end

    describe 'cost=' do
      context '1000 < cost < 5000 ' do
        subject { clazz.create cost: (1000..5000) }
        
        its(:valid?) { should be_true }
      end

      context 'cost < 0' do
        subject { clazz.create cost: (-1..5000) }
        
        its(:valid?) { should be_false }
      end

      context 'should not allow to be > 40000' do
        subject { clazz.create cost: (1000..50000) }

        its(:valid?) { should be_false }
      end
    end

    describe 'full_address=' do
      context 'Invalid place' do
        pending 'TODO'
        
        subject { clazz.create full_address: 'Blip' }
        
        # its(:valid?) { should be_false }
      end

      context 'Valid place' do
        subject { clazz.create full_address: 'Copenhagen' }
        
        its(:valid?) { should be_true }
      end
    end

    describe 'radius=' do
      context 'radius = 25' do
        subject { clazz.create radius: 25 }
        
        its(:valid?) { should be_true }
      end

      context 'radius > 50' do
        subject { clazz.create radius: 51 }
        
        its(:valid?) { should be_false }
      end

      context 'radius <= 0' do
        subject { clazz.create radius: 0 }
        
        its(:valid?) { should be_false }
      end
    end
  end
end