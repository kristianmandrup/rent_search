class Search
  include BasicDocument

  include_concerns :sortable #, :agentize

  def set_fields
    self.class.all_fields.select{|f| self.send(f) != nil }.map(&:to_sym)
  end

  # Returns the model class this Search operates on
  def subject_class
    raise NotImplementedError, "Must be implemented by subclass"
  end

  def eql?( other )
    self == other
  end 
   
  def hash
    raise NotImplementedError, "Must be implemented by subclass"
  end  
end
