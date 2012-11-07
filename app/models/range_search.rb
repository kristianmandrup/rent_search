class RangeSearch
  include BasicDocument

  include_concerns :range_fields, for: 'Search'

  belongs_to :agent

  def searcher
    @searcher ||= Property::Searcher.new
  end

  def properties
    @properties ||= find_properties
  end

  def create_agent_for user
    Agent.create self, user: user
  end

  def as_hash
    RangeSearch.all_fields.inject({}) do |res, name|
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

  # Use Searcher!
  def find_properties
    searcher.execute
  end
end
