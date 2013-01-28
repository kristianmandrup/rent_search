# encoding: utf-8

require 'spec_helper'

describe SearchableProperty do
  subject { property }

  let(:property) do
    SearchableProperty.first
  end

  let (:properties) do
    SearchableProperty.all.to_a.map(&:to_s).join("\n\n")
  end

  context 'valid property' do
    let(:number) { 10 }

    before do
      number.times do
        create :valid_searchable_property, rating: rand(4)+1, rentability: rand(3)+1
      end
    end

    context 'random searchable property' do
      it 'has rating do' do
        expect(subject.rating).to be > 0
      end

      it 'must be valid' do
        puts "Subject: #{subject}"
        subject.should be_valid
      end

      specify do
        SearchableProperty.all.size.should == number
      end

      describe 'costs' do
        specify { subject.costs.should be_a Property::Costs }
        specify { subject.entrance_cost.should > 0 }

        describe 'one_time' do
          specify { subject.costs.one_time.should be_a Property::Costs::OneTime }

          Property::Costs::OneTime.cost_types.each do |type|            
            specify do
              if subject.costs.one_time
                subject.costs.one_time.send(type).should >= 0
              end
            end
          end
        end

        describe 'monthly' do
          specify { subject.costs.monthly.should be_a Property::Costs::Monthly }

          Property::Costs::Monthly.cost_types.each do |type|            
            specify do
              if subject.costs.monthly
                subject.costs.monthly.send(type).should >= 0
              end
            end
          end
        end
      end
    end
  end   
end