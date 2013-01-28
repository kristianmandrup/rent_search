class Searcher
  module Sorting
    extend ActiveSupport::Concern

    def sorter
      @sorter ||= Searcher::Sorter.new sorter_options
    end

    def sort_order_calculator calculator_class
      raise ArgumentError, "Must be a class, was: #{calculator_class}" unless calculator_class.kind_of?(Class)
      sorter.sort_order.calculator_class = calculator_class
      self
    end

    def sorted_by *args      
      @sort_options = options_normalizer(*args).normalize
      self
    end
    alias_method :sort_by,    :sorted_by
    alias_method :order_by,   :sorted_by
    alias_method :ordered_by, :sorted_by

    def options_normalizer *args
      @options_normalizer ||= Searcher::Sort::OptionsNormalizer.new *args
    end

    # uses sort_options
    def sorter_options
      sort_options.keep_keys!(Searcher::Sorter.options_allowed)
    end

    def sort_options
      @sort_options ||= {}
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
