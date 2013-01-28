class Searcher
  module Filtering
    extend ActiveSupport::Concern

    # Array of symbols to filter out from criteria
    def only *filter_list
      filter.only filter_list
      self
    end
    alias_method :keep_all_except, :only
    alias_method :remove_only, :only
    

    # Array of symbols to filter out from criteria
    def except *filter_list
      filter.except filter_list
      self
    end
    alias_method :keep_only, :except
    alias_method :remove_all_except, :except

    # Apply filter on which criteria to Search on
    # The :filter option should be a lits of criteria keys
    #
    # Example:
    #   filter: [:rooms, :size]
    #
    def filter
      @filter ||= filter_class.new default_filter
    end

    def default_filter
      {}
    end

    protected

    def filter_class
      ::BaseSearch::Filter
    end
  end
end