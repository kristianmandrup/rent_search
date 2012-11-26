class Search
  module Sortable
    extend ActiveSupport::Concern

    # Stores the primary sorting field and sort direction of a search
    included do
      embeds_one :sort, class_name: 'Search::Sort'
    end

    attr_reader :sorting

    def sorting= sorting
      @sorting = sorting
    end    
  end
end
