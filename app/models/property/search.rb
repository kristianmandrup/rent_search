class Property
  class Search < ::Search
    include BasicDocument

    include_concerns :fields, :hasher

    belongs_to :agent, class_name: 'Property::Agent'

    def searcher
      @searcher ||= Property::Searcher.new
    end

    def properties
      @properties ||= find_properties
    end

    def create_agent_for user
      Agent.create self, user: user
    end

    # Use Searcher!
    def find_properties
      searcher.execute
    end
  end
end