### History

Search::History
  - a History stack of old Searches
  - The history can be stored in the session as an array of hashes
    - session[:search][:history]
  - Each history item can be converted to a Search
  - Each history item can be converted to an Agent (via Search)
