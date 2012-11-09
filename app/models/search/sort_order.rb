class Search
  class SortOrder
    attr_reader :name, :field_name, :direction

    # An incoming request to sort with a :name and :direction
    # The name can be mapped to a specific field_name
    #   date -> publish_date

    def initialize name = nil, direction = nil
      name ||= default_order
      @name  = label name
      @field = field_name name
      @direction = direction || sorter.direction
    end

    def self.default_order
      :created_at
    end

    def to_s
      "name: #{name}; field: #{field}; direction: #{direction}"
    end

    def label name
      name
    end    

    def field_name name
      name
    end    

    def sorter_class
      raise NotImplementedError, "Must be implemented by subclass"
    end

    def sorter
      @sorter ||= sorter_class.new field
    end
  end
end