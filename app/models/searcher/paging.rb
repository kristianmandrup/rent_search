class Searcher
  module Paging
    extend ActiveSupport::Concern

    def pager
      @pager ||= Searcher::Pager.new pager_options
    end

    def pager_options
      display_options.keep_only(Searcher::Pager.options_allowed)
    end

    # display_options includes
    #   - page: integer
    #   - order: direction and field 
    def display display_options
      @display_options = display_options
      self
    end

    def display_options
      @display_options ||= {}
    end

    def paged result = nil
      result ||= search_result
      pager.execute search_result
    end

    def paged?    
      options.paged?
    end
  end
end