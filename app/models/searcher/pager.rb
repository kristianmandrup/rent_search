class Searcher
  class Pager
    attr_reader :page_number, :per_page, :padding

    def initialize options = {}
      @page_number  = options[:page] || default_page
      @per_page     = options[:per_page]
      @padding      = options[:padding]
    end

    alias_method :page,       :page_number
    alias_method :per_page?,  :per_page
    alias_method :padding?,   :padding

    # uses
    def execute search_result
      res = search_result.page(page_number)
      res = res.per(per_page) if per_page?
      res = res.padding(padding) if padding?
      res
    end 

    def self.options_allowed
      %w{page_number per_page padding}
    end

    def default_page
      1
    end
  end
end
