class Search
  include BasicDocument

  include_concerns :fields

  belongs_to :agent

  # Returns the model class this Search operates on
  def subject_class
    raise NotImplementedError, "Must be implemented by subclass"
  end

  def agent_class
    raise NotImplementedError, "Must be implemented by subclass"
  end

  def agent_for user
    agent_class.create search: self, user: user
  end

  def as type = :criteria_hash
    subject_class.all_fields.inject({}) do |res, name|
      hash = hash_for(name)
      res.merge! hash if hash
      res
    end
  end

  protected

  def hash_for field_name
    field_value = self.send(field_name)
    return nil unless field_value
    {field_name => field_value}
  end
end
