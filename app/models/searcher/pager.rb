class Searcher
  class Pager
    attr_reader :page_number

    def initialize options = {}
      @page_number  = (options.delete(:page) || 1)
    end

    alias_method :page, :page_number

    # uses
    def execute search_result
      search_result.page(page)
    end        
  end
end
