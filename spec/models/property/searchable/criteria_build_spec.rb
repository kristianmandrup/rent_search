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

  context 'simple criteria' do
    let(:search_hash) do
      {"search"=>{"radius"=>"any", "location"=>"", "furnish"=>"any", "rooms"=>"any", "type"=>"property", "size"=>"any", "cost"=>"1", "period_from"=>"", "period_to"=>""}}
    end

    # search within 10kms of Copenhagen
    let(:criteria)  do
      puts search_hash[:search]
      c = clazz.build_from search_hash[:search]
      puts c.inspect
      c
    end

    describe 'where_criteria' do

      # RANDOM PROPERTIES
      before :each do
        5.times do
          sp = SearchableProperty.create(adv_hash)
          sp.country_code = 'DK'
        end
        # puts SearchableProperty.all.map(&:inspect)
        Mongoid::Indexing.create_indexes
      end

      specify do
        subject.where_criteria["total_rent"].should_not be_nil
      end
    end
  end
end