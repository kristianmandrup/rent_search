class Search
  include BasicDocument

  include_concerns :sortable, :agentize

  # Returns the model class this Search operates on
  def subject_class
    raise NotImplementedError, "Must be implemented by subclass"
  end
end
