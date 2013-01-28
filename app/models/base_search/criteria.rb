class BaseSearch
  class Criteria
    attr_reader :options

    def initialize options = {}
      puts "options: #{options}"
      @options = options
    end

    def builder
      raise NotImplementedError, "Must be implemented by subclass to return a subclass of Search::Criteria::Builder"
      # @builder ||= Property::Search::Criteria::Builder.new self
    end
  end
end
