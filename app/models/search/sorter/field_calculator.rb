class Search::Sorter
  class FieldCalculator
    attr_reader :sort_field, :sort_direction

    # Calculate the sort field
    def initialize sort_field, sort_direction, default_field = :created_at
      @sort_field, @sort_direction = [sort_field, sort_direction]

      @default_field = default_field if default_field
    end

    def calc
      valid? ? sort_field : default_sort_field
    end

    protected

    def valid?
      all_fields.include? sort_field.to_s
    end

    def default_sort_field
      @default_sort_field ||= :created_at
    end    
  end
end