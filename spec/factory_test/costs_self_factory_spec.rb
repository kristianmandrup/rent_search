require 'spec_helper'

describe Property::CostsSelf do
  subject { costs }

  context 'factory' do
    context 'valid' do
      let(:costs) { create :valid_costs_self }

      before :all do
        puts subject
      end

      Property::Costs::MonthlyCost.cost_types.each do |type|
        its(type)        { should >= 0  }
      end

      Property::Costs::OneTimeCost.cost_types.each do |type|
        its(type)        { should > 0  }
      end
      
      specify do
        subject.one_time.total.should > 0
      end

      its(:total_rent)      { should > 0 }

      its(:total_rent)      { should == costs.monthly.total_rent }
      its(:initial_payment) { should == costs.total_rent + costs.one_time.total }
    end
  end
end