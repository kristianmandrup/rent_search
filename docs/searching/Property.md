## Property Searching

Property::Criteria::Preferences
  - Area unit (sqm, sqfeet)
  - Currency (Euro, DKK)

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

## Property Search

Property::Search::Fields
  - contains the property search fields

Property::Search::Fields::Setter
  - Set address
    - calculates a Point from the address using geocoding
    - both the point and address are saved
    - only the point is (normally) used for search


Filter
  - can be used by Builder to filter criteria options to display to the user that still would give results

Property::Search::Display::SearchOptions
  - displays the Search/Filter choices available in a select dropdown in the UI
  - retrieves values from a YAML config file, to allow localization

Property::Search::Display::SortOptions
  - displays the Sort choices available in a Sort dropdown in the UI

Property::Search::Display::SortOptions::Calculator
  - retrieves values from a YAML config file, to allow localization
  - calculates the new Sort direction choices to render based on the current selection which is filtered out (and the reverse if available) is shown instead)