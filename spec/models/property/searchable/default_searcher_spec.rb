require 'spec_helper'

Mongoid.logger = Logger.new($stdout)
Moped.logger   = Logger.new($stdout)

describe Property::Searcher do
  subject { searcher }

  context 'Default' do
    let(:clazz) { Property::Searcher }

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

    context 'default criteria' do
      # search within 10kms of Copenhagen
      let(:searcher)  do
        clazz.new
      end

      describe 'where_criteria' do

        # RANDOM PROPERTIES
        before do
          5.times do
            sp = SearchableProperty.create adv_hash
            sp.country_code = 'DK'
          end
          SearchableProperty.first.country_code = 'SE'

          puts SearchableProperty.all.map(&:inspect)
          Mongoid::Indexing.create_indexes
        end

        specify do
          subject.where_criteria.should == {"address.country_code"=>"DK"}
        end

        specify do
          subject.search.size.should == 4
        end
      end
    end
  end
end