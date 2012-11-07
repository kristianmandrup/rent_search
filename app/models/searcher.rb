# The Searcher is always responsible for executing a search
# The Search is a document stored in the database with the criteria needed to perform
# a search
# The criteria says: WHAT to find and how to ORDER the results.

# The searcher can: 
# - page the results
# - decide to order or not
# - decide criteria to filter out, not to be used in the searching

class Searcher
  attr_reader :options
  attr_reader :results

  include_concerns :paging, :sorting, :filtering, :criteria

  def initialize options = {}
    @options = options
    configure! # configure Searcher with options
  end

  # Do the search!!
  def execute
    @results ||= perform_search
  end

  # The builder used to build a Search model from a criteria hash
  def builder
    @builder = ||= Search::Builder.new options
  end

  protected

  # Determines what kind of search to perform
  # - paged and ordered
  # - paged only
  # - ordered only
  # - basic
  def perform_search
    return paged(ordered) if paged? && ordered?
    return paged if paged? 
    return ordered if ordered?
    search
  end 

  # Executes a Search returning a Mongoid Criteria (result)
  def search_result
    search.execute
  end

  # creates a Search model from criteria hash
  def search
    @search ||= search_builder.build_from criteria_hash
  end  

  delegate :order, to: :sorter
  delegate :page,  to: :pager

  def to_s
    %Q{
Searcher:
order: #{order}
page: #{page}
criteria: #{criteria_hash}
}
  end

  protected

  def configure!
    @paged   = options[:paged]
    @ordered = options[:ordered] || options[:sorted]
  end
end
