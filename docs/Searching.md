# Searching

The searching uses Search objects. 
The topbar contains a form that creates a resource in the form of a Search object (create) with: 

- search criteria 
- current sort order

Initially the Search form is created with an empty Search (Search.new) using search#new

Any time a search criteria field (or sort order) is changed, a submit is made to
searches#create. The create controller method then renders the result of the most recent Search object created. Each search is stored in the user Session as a Hash.
The Session search history contains only the last 10 searches (FIFO stack).

In the topbar a history icon (link) is shown. clicking on this link brings up a popup with links to previous searches for the current user (in session). Clicking on any of these searches will pop this search to the top of the search list for that session.
The session will only remember the last 10 searches!

A search always contains a searcher which is in charge of doing the actual searching using the Search parameters. Search stores the parametes in the form of simple values such as rooms: 1, size: 4 etc.

## Current design

Search
 - is a document and can be saved
 - has a searcher
 - can find properties
 - has search fields 
  - numbers are linked to specific Ranges by Mapper
  - string field :furnishment and types

RangeSearch
 - is a document and can be saved
 - has a searcher
 - can find properties
 - has search fields 
  - ranges as mapped by RangeMapper, ensuring they are within allowed bounds
  - radius number field
  - string field :furnishment
  - array field for :types

Search::Result
  - should contain the result
  - and a count of the number returned
 
 Property::Criteria
  - is a document and can be saved
  - has fields for each type of criteria:
    - boolean, number, string, ...
  - has defaults for each
  - has a Builder that can build the criteria itself from a hash of values, mapping to defaults when necessary
  - can build a Hash query
  - contains the Search logic, including geo Near search
  - can calculate a Point from an address using geocoding

Property::CriteriaBuilder
  - where_criteria
  - geo_criteria

Property::Criteria::Filter
  - Used by Searcher
  - Used to filter criteria options to display to the user that still would give results
  - Init takes a Searcher

Property::Criteria::RangeMapper
  - Init: takes criteria hash and User preferences
  - Maps ranges of user selection to Valid ranges
  - Maps other criteria selections to valid selections

Property::Criteria::Preferences
  - Area unit (sqm, sqfeet)
  - Currency (Euro, DKK)

Searcher
  - contains:
    - criteria
    - criteria_hash
    - order
    - page

  - can execute and return a full result or a paged result
  - will always return an ordered result

Searcher::History
  - a History stack of old Searches
  - to be stored in the session
  - can be converted to an Agent
  - can be executed as a Search

BasicSearcher < Searcher
  - Most basic searching

GeoSearcher < Searcher
  - include Geo search functionality


Property::SortOptions
  - Options hash for Sorting
  - Ascending or Descending
  - For sort selector

Property::SearchOptions
  - The choices available in the search form
  - Currently only supports static Ranges
  - Would be nice if it could support more dynamic ranges 
    - checkbox groups
    - Slider range selection

Sorter
  - calculates and maintains the current sort order, a :field and a :direction

Searchable
  - Makes the property Searchable by including concerns (and search logic) needed
  - used by SearchableProperty