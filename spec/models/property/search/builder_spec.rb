require 'spec_helper'

describe Property::Search::Builder do
  subject { search_builder }

  let(:search_builder) { Property::Search::Builder.new criteria }

  context 'valid criteria: size:any, rooms: 1-5, cost: +3000' do
    let(:criteria) do
      {"size" => "any", "rooms" => "1-5", "cost" =>  "+3000"}
    end

    describe 'builds valid search constructor args' do    
      specify do
        subject.creation_args.should be_a Hash
      end

      specify do
        subject.creation_args.should_not be_empty
      end

      specify do
        subject.creation_args.should == {:rooms=> 1..5, :cost=> 3000..40000}
      end
    end

    describe 'builds valid search' do
      let(:search) { search_builder.build }

      it 'should not have sqm' do
        search.sqm.should == nil
      end

      it 'should have rooms [1,2,3,4,5]' do
        search.rooms.should == [1,2,3,4,5]
      end

      it 'should have cost 3000..40000' do
        search.cost.should == (3000..40000)        
      end
    end
  end

  context 'valid criteria: rooms [1,2,4]' do
    let(:criteria) do
      {"rooms" => [1,2,4], "cost" =>  "+3000"}
    end

    describe 'builds valid search' do
      let(:search) { search_builder.build }

      it 'should not have sqm' do
        search.sqm.should == nil
      end

      it 'should have rooms [1,2,4]' do
        search.rooms.should == [1,2,4]
      end
    end
  end  

  context 'valid criteria: rooms < 4 and cost > 7000' do
    let(:criteria) do
      {"rooms" => "< 4", "cost" =>  "> 7000"}
    end

    describe 'builds valid search' do
      let(:search) { search_builder.build }

      it 'should not have sqm' do
        search.cost.should == (7001..40000)
      end

      it 'should have rooms [1,2,3,4]' do
        search.rooms.should == [1,2,3]
      end
    end
  end  

  context 'valid criteria: rooms less than 3 and more than 2000' do
    let(:criteria) do
      {"rooms" => "less than 3", "cost" =>  "more than 2000"}
    end

    describe 'builds valid search' do
      let(:search) { search_builder.build }

      it 'should not have sqm' do
        search.cost.should == (2001..40000)
      end

      it 'should have rooms [1,2]' do
        search.rooms.should == [1,2]
      end
    end
  end

  context 'valid criteria: rooms 1,2 or 4' do
    let(:criteria) do
      {"rooms" => "1,2 eller 4"}
    end

    describe 'builds valid search' do
      let(:search) { search_builder.build }

      it 'should have rooms [1,2,4]' do
        search.rooms.should == [1,2,4]
      end
    end
  end

  context 'valid criteria: rooms 1 or 4' do
    let(:criteria) do
      {"rooms" => "1 eller 4"}
    end

    describe 'builds valid search' do
      let(:search) { search_builder.build }

      it 'should have rooms [1,4]' do
        search.rooms.should == [1,4]
      end
    end
  end
end
