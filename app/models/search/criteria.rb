class Search
  class Criteria
    def initialize options = {}
    end

    def builder
      @builder ||= Property::Search::Criteria::Builder.new self
    end
  end
end
