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

SearchManager - manages high level aspects of search such as History tracking, agents etc.

Searcher - performs the Search

Search - contains the Search criteria to be stored in Database
