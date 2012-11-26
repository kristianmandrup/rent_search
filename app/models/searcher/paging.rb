class Searcher
  module Paging
    extend ActiveSupport::Concern

    def pager
      # puts "pager_options: #{pager_options}"
      @pager ||= Searcher::Pager.new pager_options
    end

    def pager_options
      # puts "display_options: #{display_options} - #{Searcher::Pager.options_allowed}"
      display_options.keep_keys(Searcher::Pager.options_allowed)
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