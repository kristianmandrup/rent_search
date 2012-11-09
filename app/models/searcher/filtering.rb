class Searcher
  module Filtering
    extend ActiveSupport::Concern

    # Apply filter on which criteria to Search on
    # The :filter option should be a lits of criteria keys
    #
    # Example:
    #   filter: [:rooms, :size]
    #
    def filter
      @filter ||= Search::Filter.new
    end
  end
end