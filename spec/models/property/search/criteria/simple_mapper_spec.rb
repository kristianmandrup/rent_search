require 'spec_helper'

describe Property::Criteria::SimpleMapper do
  subject { mapper }

  let(:mapper) { Property::Criteria::SimpleMapper.new criteria_hash }

  context 'cost 1' do
    let(:criteria_hash) do
      {"radius"=>"any", "location"=>"", "furnishment"=>"any", "rooms"=>"any", "type"=>"property", "size"=>"any", "cost"=>"1", "period_from"=>"", "period_to"=>""}
    end

    describe 'mapped criteria' do
      specify {
        subject.mapped_hash.should == {:total_rent=>0..3000} 
      }
    end
  end

  context 'size' do
    context '0' do
      let(:criteria_hash) do
        {"radius"=>"any", "location"=>"", "furnishment"=>"any", "rooms"=>"any", "type"=>"property", "size"=>"0", "cost"=>"any", "period_from"=>"", "period_to"=>""}
      end

      describe 'mapped criteria' do
        specify {
          subject.mapped_hash.should == {"size"=> 0..1000}
        }
      end
    end

    context '1' do
      let(:criteria_hash) do
        {"radius"=>"any", "location"=>"", "furnishment"=>"any", "rooms"=>"any", "type"=>"property", "size"=>"1", "cost"=>"any", "period_from"=>"", "period_to"=>""}
      end

      describe 'mapped criteria' do
        specify {
          subject.mapped_hash.should == {"size"=> 12..20}
        }
      end
    end

    context '4' do
      let(:criteria_hash) do
        {"radius"=>"any", "location"=>"", "furnishment"=>"any", "rooms"=>"any", "type"=>"property", "size"=>"4", "cost"=>"any", "period_from"=>"", "period_to"=>""}
      end

      describe 'mapped criteria' do
        specify {
          subject.mapped_hash.should == {"size"=>100..150}
        }
      end
    end

    context '10 (outside bounds)' do
      let(:criteria_hash) do
        {"radius"=>"any", "location"=>"", "furnishment"=>"any", "rooms"=>"any", "type"=>"property", "size"=>"10", "cost"=>"any", "period_from"=>"", "period_to"=>""}
      end

      describe 'mapped criteria' do
        specify {
          puts subject.mapped_hash
          subject.mapped_hash.should == {"size"=> 0..1000}
          # expect { subject.mapped_hash }.to raise_error(ArgumentError)
        }
      end
    end
  end

  context 'furnishment' do
    context '1' do
      let(:criteria_hash) do
        {"radius"=>"any", "location"=>"", "furnishment"=>"1", "rooms"=>"any", "type"=>"property", "size"=>"any", "cost"=>"any", "period_from"=>"", "period_to"=>""}
      end

      describe 'mapped criteria' do
        specify {
          subject.mapped_hash.should == {}
        }
      end
    end

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