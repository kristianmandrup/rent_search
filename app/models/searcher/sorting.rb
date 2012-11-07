class Searcher
  module Sorting
    extend ActiveSupport::Concern

    def sorter
      @sorter ||= Searcher::Sorter.new options
    end

    def ordered result = nil
      result ||= search_result
      sorter.execute search_result
    end
    alias_method :sorted, :ordered

    def ordered?    
      @ordered == true
    end
    alias_method :sorted?, :ordered?

    def ordered!
      @ordered = true
    end
    alias_method :sorted!, :ordered!
  end
end
