# Responsible for creating a new search and 
class Search
  class Manager
    attr_reader :user, :storage, :history

    def initialize user, storage = nil
      @storage = storage
      @user = user
    end

    def self.build
      RangeSearch.new
    end

    # options
    # :agent - to add as agent
    def store criteria, options = {}
      criteria = normalized criteria

      unless valid_criteria? criteria
        raise ArgumentError, "Search criteria to be stored must be a valid hash, was: #{criteria}" 
      end

      # TODO - normalize criteria, filter out any non-valid keys/values

      history.push criteria
      search = RangeSearch.create criteria

      if options[:agent]
        search.create_agent_for user
      end
    end

    def storage
      @storage ||= Search::History.new
    end
    alias_method :history, :storage

    protected

    def normalized criteria
      case criteria
      when RangeSearch
        criteria.as_hash
      when Hash
        criteria
      else
        raise ArgumentError, "Invalid criteria, was: #{criteria}, must be a RangeSearch or Hash"
      end
    end

    def valid_criteria? criteria
      criteria && !criteria.blank? && criteria.kind_of?(Hash)
    end
  end
end