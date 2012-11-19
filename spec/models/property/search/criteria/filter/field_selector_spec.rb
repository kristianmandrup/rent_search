require 'spec_helper'

describe Property::Search::Criteria::Filter::FieldSelector do
  subject { filterer }

  def field_clazz_for name
    "Property::#{name.to_s.camelize}".constantize
  end

  context '10 valid properties' do
    before :each do
      5.times do |n|
        Delorean.time_travel_to(n.minutes.from_now) do
          create :valid_searchable_property
        end
      end
      puts SearchableProperty.all[0..3]
    end
    
    let(:filterer) { Property::Search::Criteria::Filter::FieldSelector.new SearchableProperty.all }

    # describe '.each' do
    #   specify do
    #     filterer.each do |item|        
    #       item.should be_a SearchableProperty
    #     end
    #   end
    # end

    # values for a single field, fx type
    describe '.values_for :type' do
      specify do
        filterer.values_for_field(:type).each do|name|
          name.should be_in Property::Type.valid_values
        end
      end
    end

    describe '.values_for :type, :furnishment ' do
      specify do
        filterer.values_for(:type, :furnishment).each do|(key, list)|
          key.should be_in(:type, :furnishment)
          (list & field_clazz_for(key).valid_values).should == list
        end
      end
    end

    describe '.selected_fields' do
      specify do
        filterer.selected_fields(:parking, :washing_machine).should == [:parking]
      end      
    end
  end
end
