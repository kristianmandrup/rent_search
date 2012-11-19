require 'spec_helper'

class SettersDoc
  include BasicDocument

  include Property::Search::Fields::TypeMapping
  include Property::Search::Fields::Setters
end

describe Property::Search::Fields::Setters do
  let(:clazz) { SettersDoc }

  describe 'do NOT allow type room with # of rooms defined' do
    subject { clazz.create rooms: 1..2, types: ['room'] }

    its(:rooms)   { should == [1] }
    its(:types)   { should == ['room'] }
  end

  describe 'setters' do
    subject { clazz.create }

    describe 'shared=' do
      specify do
        subject.shared = true
        subject.shared.should == true
      end
    end

    describe 'country_code=' do
      specify do
        subject.country_code = 'DK'
        subject.country_code.should == 'DK'
      end

      specify do
        subject.country_code = 'EN'
        subject.country_code.should == subject.send(:default_country_code)
      end      
    end

    describe 'valid_country_code?' do
      specify do
        subject.valid_country_code?('DK').should be_true
      end
    end

    describe 'types=' do
      specify do
        subject.types = ['room', 'apartment']
        subject.types.should == ['room', 'apartment']
      end
    end

    describe 'size=' do
      specify do
        subject.size = (6..20)
        subject.size.should == (6..20)
      end
    end

    # Allow Array
    describe 'rooms=' do
      describe 'set with Array' do
        specify do
          subject.rooms = [1,2,4]
          subject.rooms.should == [1,2,4]
        end
      end

      describe 'set with Range' do
        specify do
          subject.rooms = (1..3)
          subject.rooms.should == (1..3).to_a
        end
      end
    end

    describe 'period=' do
      let(:time_period) { Timespan.new duration: 5.days }

      specify do
        subject.period = time_period
        subject.period.should == time_period
      end
    end

    describe 'cost=' do
      specify do
        subject.cost = (1000..5000)
        subject.cost.should == (1000..5000)
      end
    end

    describe 'total_rent=' do
      specify do
        subject.total_rent = (1000..5000)
        subject.cost.should == (1000..5000)
      end
    end

    describe 'full_address=' do
      specify do
        subject.full_address = 'Copenhagen'
        subject.point.should == subject.send(:calc_point, 'Copenhagen')
      end
    end

    describe 'radius=' do
      specify do
        subject.radius = 5
        subject.radius.should == 5
      end
    end
  end
end