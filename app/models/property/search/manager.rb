class Property::Search < BaseSearch
  class Manager < BaseSearch::Manager
    def initialize  user, storage = nil
      super
    end

    def search_class
      Property::Search
    end
  end
end
