class Property::Search
  class Builder
    attr_reader :criteria, :preferences

    def initialize criteria, preferences = nil
      @criteria = criteria
      @preferences = preferences || pref_class.new
    end

    def build
      search_class.create creation_args
    end

    def search_class
      Property::Search
    end

    def pref_class
      search_class::Preferences
    end


    # Example:
    # {rooms: '1-2', size: '50-100', ...}
    def creation_args
      # Using Ranges mapper
      mapper.build criteria, preferences, :ranges
    end

    def mapper
      Property::Search::Criteria::Mapper
    end
  end
end