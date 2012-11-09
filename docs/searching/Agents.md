## Agent

Search::Agentize
  - included in a Search model to make it Agentizable
  - will make the search embeddable in a Search::Agent
  - can convert Search to an Agent (embedded in an Agent)

Search::Agent
  - A wrapper of a Search that can be executed as a background job on the server
  - Maintains certain agent stats
    - name (by default: generate name that matches search sentence in UI, localized)
    - last time executed
    - number of times executed
    - Array of ids (resultset) from last execution
    - expiry date (when to be deleted)
