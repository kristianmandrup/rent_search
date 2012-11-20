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

  include_concerns :paging, :sorting, :filtering, :criteria, :config

  # Usage
  # 
  # Create the searcher with basic config options, use pager and/or orderer/sorter
  #   searcher = Searcher.new(:pager)

  # Then on each execution configure display, finder and filter options and execute!
  #   Examples:
  #
  #   searcher.display(page: 1).find(criteria).only(:rooms).execute
  #   searcher.display(page: 1).find(rooms: 2..4, size: '+50').except(:rooms).execute

  #   searcher.display(page: 1).find(rooms: '2-3').except(:size).execute

  def initialize options = {}
    @options = normalize_options options    
  end

  # criteria
  #   - hash of search criteria to use (if not filtered)
  def find criteria = {}
    raise ArgumentError, "Criteria must be a hash" unless criteria.kind_of?(Hash)    
    @criteria = criteria
    self
  end

  # Execute the search!!
  def execute
    @results ||= perform_search
  end

  # Executes a Search returning a Mongoid Criteria (result)
  def search_result
    search.execute
  end

  # creates a Search model using the Search builder
  def search
    @search ||= search_builder.build
  end   

  # The builder used to build a Search model from:
  #   - filtered criteria hash
  #   - preferences
  def search_builder
    @search_builder ||= search_builder_class.new(filtered_criteria, preferences)
  end  

  delegate :order, to: :sorter
  delegate :page,  to: :pager   

  def search_builder_class
    search_class::Builder
  end

  # Criteria knows how to build the Search criteria
  def search_class
    raise NotImplementedError, "Must be implemented by subclass"
  end

  def preferences
    @preferences ||= pref_class.new pref_options if options == nil
  end

  def set_preferences options = {}    
    raise ArgumentError, "Options must be a hash" unless options.kind_of?(Hash)
    @pref_options = options
    @preferences = nil # reset
  end

  def pref_options
    @pref_options ||= {}
  end

  def pref_class
    search_class::Preferences
  end
  alias_method :preferences_class, :pref_class

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
    basic_search    
  end 

  def basic_search
    search_result
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
