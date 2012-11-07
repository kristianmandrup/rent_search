class Searcher
  module Filtering
    extend ActiveSupport::Concern

    def filter
      @filter ||= Search::Filter.new options[:filter] if options[:filter]
    end
  end
end