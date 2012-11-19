require 'spec_helper'

require 'models/property/searcher/controller'

describe Property::Search::History do
  include ::CriteriaSpecHelper

  let(:params) do
    Hashie::Mash.new(params_hash)
  end

  let(:params_hash) do
    {"search" => {
      "radius"=>"any", 
      "location"=>"", 
      "furnishment"=>"any", 
      "rooms"=>"any", 
      "type"=>"property", 
      "size"=>"any", 
      "cost"=>"any",
      "rating"=>"any", 
      "rentability"=>"any",
      "period_from"=>"", 
      "period_to"=>"", 
      "sort"=>"date::asc"
    }}  
  end

  include Searcher::Controller

  context 'any criteria' do
    describe 'search with where criteria' do
      context 'criteria' do
        subject { history }

        let(:history) { Property::Search::History.new 10 }
        
        let(:search_1) do
          {"radius"=>"2", "location"=>"Vesterbro"}
        end

        let(:search_2) do
          {"radius"=>"12", "location"=>"Valby"}
        end

        context' empty history' do
          before :each do
            @history = history
          end

          its(:max_size) { should == 10 }
          its(:full?)    { should be_false }
          its(:empty?)   { should be_true }

          specify do            
            @history.push(search_hash)
            @history.push(search_1)

            @history.last.should == search_1
            @history.empty?.should_not be_true

            @history.push(search_2)
            @history.last.should == search_2
            @history.full?.should_not be_true
          end
        end
      end
    end
  end
end
