class Search
  module Hasher
    extend ActiveSupport::Concern

    def as_hash type = nil
      subject_class.all_fields.flatten.inject({}) do |res, name|
        hash = hash_for(name, type)
        res.merge! hash if hash
        res
      end
    end

    protected

    def hash_for field_name, type = nil
      field_name = type == :symbol ? field_name.to_sym : field_name.to_s
      field_value = self.send(field_name)
      return nil unless field_value
      {field_name => field_value}
    end    
  end
end