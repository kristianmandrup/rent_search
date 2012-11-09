## Search

A Search encapsulates the actual criteria values use in a search. It can be stored in the database.

Search
 - is a document and can be saved
 - has search fields 
 - can be converted to: 
  - an Agent
  - a Hash (see Hasher)

Search::Filter
  - can filter a criteria hash or Search object by applying Search::Filter on it
  - uses HashApplier or Applier
 
Search::Hasher
  - can return a Search as a hash
  - useful when storing Search as a history entry

## Result

Search::Result
  - should contain the result as Criteria
  - return number of results returned
  - Hash of new Display criteria to be used for updating UI
