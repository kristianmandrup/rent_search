### Sorting

Search::Sortable
  - included in a Search model to make it Sortable
  - will embed a Search::Sort

Search::Sort
  - contains the sort fields for a search
    - direction (:asc or :desc)
    - name (name of field to be sorted on)
  - Validates on which field names can be sorted
  - Always allows sorting in any direction


## IO Mapping

Search::Io::SortMapper
  - can map a sort string in the form "asc::date", coming from outside to a Sort object
  - can map a Sort object to a sort string, fx in the form "asc::date"

Search::Io::SortOptions
  - can map a sort string in the form "asc::date", coming from outside to a Sort object
  - can map a Sort object to a sort string, fx in the form "asc::date"

Search::Io::SortParser
  - can map a sort string in the form "asc::date", coming from outside to a Sort object
  - can map a Sort object to a sort string, fx in the form "asc::date"
