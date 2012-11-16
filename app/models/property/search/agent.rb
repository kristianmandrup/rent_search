class Property
  class Search < ::Search
    class Agent < ::Search::Agent  
      include BasicDocument
    end
  end
end