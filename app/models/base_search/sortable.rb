class BaseSearch
  module Sortable
    extend ActiveSupport::Concern

    # Stores the primary sorting field and sort direction of a search
    included do
      embeds_one :sort, class_name: 'BaseSearch::Sort'
    end

    attr_reader :sorting

    # what is it?
    def sorting= sorting
      @sorting = sorting      
      @sort_hash = nil
      self.sort = BaseSearch::Sort.create sort_hash
    end    

    def sort_hash
      @sort_hash ||= BaseSearch::Sorting::Parser.new(sorting).parse
    end
  end
end
