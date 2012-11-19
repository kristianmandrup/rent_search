require 'spec_helper'

describe Property::Search::Criteria::Mapper::Ranges do
  subject { mapper }

  let(:mapper) { clazz.new criteria_hash }

  let(:clazz)  { Property::Search::Criteria::Mapper::Ranges }

  context 'cost 0-3000' do
    let(:criteria_hash) do
      {"radius"=>"any", "location"=>"", "furnishment"=>"any", "rooms"=>"any", "type"=>"property", "size"=>"any", "cost"=>"0-3000", "period_from"=>"", "period_to"=>""}
    end

    describe 'mapped criteria' do
      specify {
        subject.mapped_hash.should == {:total_rent=>0..3000} 
      }
    end
  end

  context 'size' do
    context '6-100' do
      let(:criteria_hash) do
        {"radius"=>"any", "location"=>"", "furnishment"=>"any", "rooms"=>"any", "type"=>"property", "size"=>"6-100", "cost"=>"any", "period_from"=>"", "period_to"=>""}
      end

      describe 'mapped criteria' do
        specify {
          subject.mapped_hash.should == {"size"=> 6..100}
        }
      end
    end

    context '1000-5000' do
      let(:criteria_hash) do
        {"radius"=>"any", "location"=>"", "furnishment"=>"any", "rooms"=>"any", "type"=>"property", "size"=>"1000-5000", "cost"=>"any", "period_from"=>"", "period_to"=>""}
      end

      describe 'mapped criteria' do
        specify {
          puts subject.mapped_hash
          subject.mapped_hash.should == {"size"=> 5..1000}
          # expect { subject.mapped_hash }.to raise_error(ArgumentError)
        }
      end
    end
  end

  context 'furnishment' do
    context 'any' do
      let(:criteria_hash) do
        {"radius"=>"any", "location"=>"", "furnishment"=>"any", "rooms"=>"any", "type"=>"property", "size"=>"any", "cost"=>"any", "period_from"=>"", "period_to"=>""}
      end

      describe 'mapped criteria' do
        specify {
          subject.mapped_hash.should == {}
        }
      end
    end

    context '(blank)' do
      let(:criteria_hash) do
        {"radius"=>"any", "location"=>"", "furnishment"=>"", "rooms"=>"any", "type"=>"property", "size"=>"any", "cost"=>"any", "period_from"=>"", "period_to"=>""}
      end

      describe 'mapped criteria' do
        specify {
          subject.mapped_hash.should == {}
        }
      end
    end

    context 'unfurnished' do
      let(:criteria_hash) do
        {"radius"=>"any", "location"=>"", "furnishment"=>"unfurnished", "rooms"=>"any", "type"=>"property", "size"=>"any", "cost"=>"any", "period_from"=>"", "period_to"=>""}
      end

      describe 'mapped criteria' do
        specify {
          subject.mapped_hash.should == {"furnishment"=> "unfurnished"}
        }
      end
    end

    context 'furnished' do
      let(:criteria_hash) do
        {"radius"=>"any", "location"=>"", "furnishment"=>"furnished", "rooms"=>"any", "type"=>"property", "size"=>"any", "cost"=>"any", "period_from"=>"", "period_to"=>""}
      end

      describe 'mapped criteria' do
        specify {
          subject.mapped_hash.should == {"furnishment"=> "furnished"}
        }
      end
    end
  end
end