## Generic Search

### Searcher

A Searcher performs the actual search
  - can execute a Search and return a Search::Result
  - can be configured to order/sort or page the result (return results as a number of pages)

Searcher::Base
  - basic search functionality/API

Searcher::Geo < Base
  - can only perform a Geo search using near

Searcher::Simple < Base
  - can perform Search without geo functionality

Searcher::Full < Base
  - combines GeoSearcher and SimpleSearcher to do a full search

Searcher::Criteria
  - can get the filtered criteria by applying a Searcher::Filter
  - can get the Search criteria hash

# TODO: duplicate logic? 
Searcher::Filtering
  - can filter a criteria hash or Search using Search::Filter

Searcher::Options
  - contains options for paging and ordering the Search result

Searcher::ConfigOptions
  - functionality to handle/validate Searcher::Options for a Searcher

Searcher::Paging
  - adds paging functionality to Searcher
  - adds Searcher::Pager

Searcher::Sorting
  - adds sorting functionality to Searcher
  - adds Searcher::Sorter










