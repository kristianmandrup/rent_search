require 'spec_helper'

class SearchCriteria
  include Search::Criteria
end

describe Search::Criteria do
  subject { criteria }

  let(:criteria) { SearchCriteria.create :cost 1 }
end
