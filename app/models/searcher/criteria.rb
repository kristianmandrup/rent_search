class Searcher
  module Criteria
    extend ActiveSupport::Concern

    def criteria_hash
      @criteria_hash ||= filter.apply_on(criteria)
    end

    def search_criteria
      @search_criteria ||= search.as(:criteria_hash)
    end
  end
end