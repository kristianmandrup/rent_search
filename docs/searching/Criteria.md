## Criteria
 
Search::Criteria
  - knows how to build a Search Criteria (Hash or Array) for use in a #where or #near search statement
  - has a Builder that can build the criteria

### Builder

Search::Criteria::Builder
  - builds up a Criteria for use in search
  - can uses specific Builder for more complex types, fx Timespan
  - can use filter to filter out certain criteria elements 

Search::Criteria::Builder::Filter
  - can be used by Builder to filter out certain criteria elements 

### Input

The Mappers are used to convert strings from the UI to valid internal model values.

Search::Criteria::Mapper::Base
  - Maps a Hash to a valid Search construction Hash
  - Can map a criteria Hash as received from the outside to a Valid hash
  - Uses a Search::Preferences to determine Area unit and Currency used in mapping

Search::Criteria::Mapper::Simple < Base
  - Can map Integer values, fx from 0-4 to specific ranges (old style)

Search::Mapper::Ranges
  - Can map Ranges ("0-4" rooms) to valid ranges (1..4)
