# The Searcher is always responsible for executing a search
# The Search is a document stored in the database with the criteria needed to perform
# a search
# The criteria says: WHAT to find and how to ORDER the results.

# The searcher can: 
# - page the results
# - decide to order or not
# - decide criteria to filter out, not to be used in the searching

class Searcher
  attr_reader :searcher_options, :display_options, :criteria
  attr_reader :results

  include_concerns :paging, :sorting, :filtering, :criteria, :config_options

  # Usage
  # 
  # Create the searcher with basic config options, use pager and/or orderer/sorter
  #   searcher = Searcher.new(:pager)

  # Then on each execution configure display and finder options and execute!
  #   searcher.display(page: 1).find(criteria).execute

  def initialize searcher_options
    @searcher_options = normalize_options searcher_options    
  end

  # criteria
  #   - hash of search criteria
  def find criteria = {}    
    @criteria = criteria
    self
  end

  # display_options includes
  #   - page: integer
  #   - order: direction and field 
  def display display_options
    @display_options = display_options
    self
  end

  # Array of symbols to filter out from criteria
  def only *filter_list
    filter.only_list = filter_list.flatten
  end

  # Array of symbols to filter out from criteria
  def except *filter_list
    filter.except_list = filter_list.flatten
  end

  # Do the search!!
  def execute
    @results ||= perform_search
  end

  # The builder used to build a Search model from a criteria hash
  def search_builder
    @search_builder = ||= builder_class.new options
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

  def builder_class
    raise NotImplementedError, "Must be implemented by subclass"
  end

  def to_s
    %Q{
Searcher:
order: #{order}
page: #{page}
criteria: #{criteria_hash}
}
  end
end
