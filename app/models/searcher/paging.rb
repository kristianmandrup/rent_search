class Searcher
  module Paging
    extend ActiveSupport::Concern

    def pager
      @pager ||= Searcher::Pager.new options
    end

    def paged result = nil
      result ||= search_result
      pager.execute search_result
    end

    def paged?    
      @paged == true
    end

    def paged!
      @paged = true
    end
  end
end