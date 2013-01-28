class Property::Search < BaseSearch
  class Agent < BaseSearch::Agent  
    include BasicDocument
  end
end