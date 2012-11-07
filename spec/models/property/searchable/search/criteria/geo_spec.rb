# encoding: UTF-8
require 'spec_helper'

describe SearchCriteria do
  include SearchSetup
  
  context 'Properties within period 10 days from now' do
    let(:search_criteria) do    
      create :search_criteria, near: 'Copenhagen', radius: 5 # 5 km
    end

    let(:expected) do
      {"$near" => {"location" => "Copenhagen", "radius" => ["5", "km"] }}
    end

    specify do
      search_criteria.geo_criteria.should == expected
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
