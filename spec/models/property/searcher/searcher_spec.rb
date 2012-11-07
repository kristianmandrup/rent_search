require 'spec_helper'

require 'models/property/searcher/controller'

describe Property::Searcher do
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
        subject { criteria }

        let(:criteria) { searcher.criteria }
        
        its(:type)          { should == "property" }
        its(:furnishment)   { should == "any" }
        its(:full_address)  { should == "Copenhagen" }
        its(:country_code)  { should == "DK" }
        its(:radius)        { should == 50 }
        its(:total_rent)    { should == (0..40000) }
        its(:sqm)           { should == (0..1000) }
        its(:sqfeet)        { should == (0..10000) }
        its(:rating)        { should == (0..5) }
        its(:rentability)   { should == (0..5) }
        its(:rooms)         { should == (1..10) }
        its(:period)        { should be_a Timespan }
        its('period.asap?')  { should be_false }
        its(:point)         { should == [12.5683371, 55.6760968] }
      end

      context 'search criteria' do
        subject { search_result }

        let(:search_result) { searcher.search }        
    
        specify do
          search_result.selector.should == {"address.country_code"=>"DK"}
        end

        # sort published_at, ascending
        specify do
          search_result.options.should == {:sort=>{"published_at"=>1}}
        end
      end

      context 'search properties' do
        subject { search_result }

        let(:search_result) { searcher.search.all }

        # RANDOM PROPERTIES
        before :each do
          10.times do
            create :valid_searchable_property
          end
          puts SearchableProperty.all #.map(&:inspect)
          Mongoid::Indexing.create_indexes
        end

        specify do
          search_result.size.should > 0
        end
      end
    end
  end
end
