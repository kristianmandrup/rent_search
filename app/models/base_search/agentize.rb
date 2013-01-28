class BaseSearch
  module Agentize
    extend ActiveSupport::Concern

    included do
      belongs_to :agent, class_name: agent_class.to_s, inverse_of: :search
      agent_class.has_one :search, class_name: self.to_s, inverse_of: :agent
    end

    def agent_for user
      agent_class.create search: self, user: user
    end

    module ClassMethods
      def agent_class
        raise NotImplementedError, "Must be implemented by subclass"
      end
    end
  end
end