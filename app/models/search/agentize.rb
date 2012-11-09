class Search
  module Agentize
    extend ActiveSupport::Concern

    included do
      belongs_to :agent
    end

    def agent_class
      raise NotImplementedError, "Must be implemented by subclass"
    end

    def agent_for user
      agent_class.create search: self, user: user
    end
  end
end