class Searcher
  class Pager
    attr_reader :page_number, :per, :padding

    def initialize options = {}
      @page_number  = options[:page]
      @per_page     = options[:per_page]
      @padding      = options[:padding]
    end

    alias_method :page, :page_number

    # uses
    def execute search_result
      res = search_result.page(page_number)
      res = res.per(per_page) if per_page
      res = res.padding(padding) if per_page
      res
    end 

    def self.options_allowed
      %w{page_number per_page padding}
    end
  end
end
