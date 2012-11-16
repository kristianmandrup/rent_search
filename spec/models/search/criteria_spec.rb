require 'spec_helper'

class SearchCriteria < Search::Criteria
  include BasicDocument
end

describe Search::Criteria do
  subject { criteria }

  let(:criteria) { SearchCriteria.new cost: 1 }

  pending 'TODO'
end
