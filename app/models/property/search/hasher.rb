class Property::Search
  module Hasher
    extend ActiveSupport::Concern

    def as_hash
      Search.all_fields.inject({}) do |res, name|
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
end