# encoding: UTF-8
require 'spec_helper'
require 'models/property/search/criteria/spec_helper'

describe Property::Search::Criteria do
  include SearchSetup
  
  context 'rules' do
    let(:search_criteria) do    
      create :search_criteria, rules: {smoking: true, pets: true}
    end

    specify do
      # search_criteria.geo_criteria.should == 
    end    

    # specify do
    #   # puts "criteria: #{search_criteria.criteria.inspect}"
    #   # puts "properties: #{Property.all.count} - results: #{results.count}"
    #   results.all.each do |result|
    #     result.active_rental_period.period.between? from_date, to_date
    #   end
    # end    
  end  

  context 'equipment' do
  end

  context 'whiteware' do
  end

  context 'facilities' do
    let(:search_criteria) do    
      create :search_criteria, rules: {smoking: true, pets: true}
    end

    specify do
      # search_criteria.geo_criteria.should == 
    end    

    # specify do
    #   # puts "criteria: #{search_criteria.criteria.inspect}"
    #   # puts "properties: #{Property.all.count} - results: #{results.count}"
    #   results.all.each do |result|
    #     result.active_rental_period.period.between? from_date, to_date
    #   end
    # end    
  end  
end
