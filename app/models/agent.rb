class Agent
  include BasicDocument

  field :name,        type: String, default: ''
  field :description, type: String, default: ''

  has_one :search

  def empty?
    self.search == nil
  end

  def to_search
    search
  end

  before_save do
    # TODO: create search sentence from criteria? or better: do this in Search model
    self.description = 'new search' 
  end
end