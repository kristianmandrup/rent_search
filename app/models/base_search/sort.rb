class BaseSearch
  class Sort
    include BasicDocument

    def self.default_name
      valid_sort_fields.first
    end

    def self.valid_sort_fields
      [:created_at]
    end

    field :name,      type: String, default: default_name
    field :direction, type: String, default: 'asc'

    validates :name,      presence: true, inclusion: {in: valid_sort_fields }
    validates :direction, presence: true, inclusion: {in: ['asc', 'desc']}

    def self.construct name, direction
      self.create name: name, direction: direction
    end

    def name= value
      value = self.class.default_name unless valid_sort_field? value
      super(value)
    end

    protected

    def valid_sort_field? name
      self.class.valid_sort_fields.include? name.to_sym
    end    
  end
end