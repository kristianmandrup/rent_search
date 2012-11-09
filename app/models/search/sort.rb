class Search
  class Sort
    include BasicDocument

    field :name,      type: String, default: default_name
    field :direction, type: String, default: 'asc'

    validates :name,      presence: true, inclusion: {in: valid_sort_fields }
    validates :direction, presence: true, inclusion: {in: ['asc', 'desc']}

    def name= value
      value = self.class.default_name unless valid_sort_field? value
      super(value)
    end

    protected

    class << self
      # to be implemented by subclass
      def valid_sort_fields
        []
      end

      def default_name
        :created_at
      end
    end
  end
end