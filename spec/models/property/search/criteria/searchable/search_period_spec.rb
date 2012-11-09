require 'spec_helper'

describe Property::Criteria do
  subject { criteria }

  let(:clazz) { Property::Criteria }

  include ::CriteriaSpecHelper

  context 'rooms criteria' do
    def adv_search_hash
      {
        period: search_period
      }
    end  

    # search within 10kms of Copenhagen
    let(:criteria)  do
      c = clazz.create adv_search_hash
      puts c.inspect
      c
    end

    describe 'search with where criteria' do
      let(:search_result) { subject.search_where }

      # RANDOM PROPERTIES
      before :each do
        10.times do
          sp = SearchableProperty.create
          sp.period.dates = period
          sp.country_code = 'DK'            
        end
        puts SearchableProperty.all #.map(&:inspect)
        Mongoid::Indexing.create_indexes
      end

      specify do
        subject.where_criteria.should == {"address.country_code"=>"DK", "period.dates.from"=>{"$gte"=> search_period.start_date.to_i }, "period.dates.to"=>{"$lte"=> search_period.end_date.to_i }}
      end

      it 'should have only search results that match criteria' do
        search_result.size.should be_between(1, 10)
        search_result.each do |found|

          found.period.start_date.to_i.should <= search_period.start_date.to_i
          found.period.end_date.to_i.should <= search_period.end_date.to_i

          found.country_code.should == 'DK'
        end
        puts "RESULTS found: #{search_result.size}"
      end
    end
  end
end