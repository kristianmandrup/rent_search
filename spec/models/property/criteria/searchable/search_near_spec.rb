require 'spec_helper'
# require 'models/searchable/criteria/helpers/searchable_property'

# Mongoid.logger = Logger.new($stdout)
# Moped.logger   = Logger.new($stdout)

describe Property::Criteria do
  subject { criteria }

  let(:clazz) { Property::Criteria }

  include ::CriteriaSpecHelper

  def adv_hash
    {
      rooms: rooms, 
      size: size,
      cost: cost, 
      position: position,
      shared: true
    }
  end

  context 'full criteria' do
    # search within 10kms of Copenhagen
    let(:criteria)  do
      c = clazz.create adv_search_hash
      puts c.inspect
      c
    end

    describe 'search with near criteria' do
      let(:search_result) { subject.search_near }

      # RANDOM PROPERTIES
      before :each do
        5.times do
          sp = SearchableProperty.create(adv_hash)
          sp.country_code = 'DK'          
            
          # puts "CREATED COUNTRY CODE: #{sp}"
        end
        # puts SearchableProperty.all #.map(&:inspect)
        Mongoid::Indexing.create_indexes
      end

      it 'should have only search results that match criteria' do
        search_result.size.should be_between(1, 10)
        search_result.each do |found|
          found.latitude.should     be_within(0.00314).of latitude
          found.longitude.should    be_within(0.00314).of longitude
        end
        puts "RESULTS found: #{search_result.size}"
      end
    end
  end
end
  