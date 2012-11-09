class Search
  class Sort
    include BasicDocument

    def self.default_name
      :created_at
    end

    def self.valid_sort_fields
      []
    end


    field :name,      type: String, default: default_name
    field :direction, type: String, default: 'asc'

    validates :name,      presence: true, inclusion: {in: valid_sort_fields }
    validates :direction, presence: true, inclusion: {in: ['asc', 'desc']}

    def name= value
      value = self.class.default_name unless valid_sort_field? value
      super(value)
    end
  end
end