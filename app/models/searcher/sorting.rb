class Searcher
  module Sorting
    extend ActiveSupport::Concern

    def sorter
      @sorter ||= Searcher::Sorter.new sorter_options
    end

    def sort_order_calculator calculator_class
      sorter.sort_order.calculator_class = calculator_class
      self
    end

    def sorted_by sort_options
      @sort_options = sort_options
      self
    end
    alias_method :sort_by,    :sorted_by
    alias_method :order_by,   :sorted_by
    alias_method :ordered_by, :sorted_by

    def sort_options
      @sort_options ||= {}
    end

    def sorter_options
      sort_options.keep_only(Searcher::Sorter.options_allowed)
    end

    def ordered result = nil
      result ||= search_result
      sorter.execute search_result
    end
    alias_method :sorted, :ordered

    def ordered?    
      options.ordered?
    end
    alias_method :sorted?, :ordered?
  end
end
