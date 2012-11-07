class Agent
  class Simple < ::Agent
    embedded_in :agent_user

    def user= user
      self.agent_user = user
    end
  end
end