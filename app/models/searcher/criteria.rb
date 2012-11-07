class Searcher
  module Criteria
    extend ActiveSupport::Concern

    def criteria_hash
      @criteria_hash ||= filter.apply_on(criteria_options)
    end

    def criteria_options
      @criteria_options ||= options.reject_keys(:paged, :ordered, :sorted)
    end

    def criteria
      @criteria ||= search.as(:criteria_hash)
    end
  end
end