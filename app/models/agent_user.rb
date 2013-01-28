class AgentUser
  include BasicDocument

  embeds_many :agents, class_name: 'BaseSearch::Agent'

  field :name, type: String, default: 'noname'

  def agent
    agents.last
  end
end