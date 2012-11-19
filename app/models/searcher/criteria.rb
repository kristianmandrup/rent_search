class Searcher
  module Criteria
    extend ActiveSupport::Concern

    # Criteria knows how to build the Search criteria
    def criteria_class
      raise NotImplementedError, "Must be implemented by subclass"
    end

    def criteria_hash
      @criteria_hash ||= filter.apply_on(criteria)
    end

    def search_criteria
      @search_criteria ||= search.as(:criteria_hash)
    end
  end
end