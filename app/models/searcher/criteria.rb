class Searcher
  module Criteria
    extend ActiveSupport::Concern

    def criteria
      @criteria ||= {}
    end

    def criteria_builder
      @search_builder ||= criteria_class.new options
    end  

    def criteria_class
      search_class::Criteria
    end

    def filtered_criteria
      @filtered_criteria ||= filter.apply_on(criteria)
    end

    def search_criteria
      @search_criteria ||= search.as(:criteria_hash)
    end
  end
end