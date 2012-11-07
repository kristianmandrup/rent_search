class Search
  class SortOrder
    attr_reader :name, :field, :direction

    def initialize name = nil, direction = nil
      name ||= Property::SortOrder.default_order
      @name = mapped name
      @field = field_name name
      @direction = direction || orderer.direction
    end

    def self.default_order
      :published_at
    end

    def reverse
      direction == :asc ? :desc : :asc
    end

    def reverse!
      @direction = reverse
    end

    def to_s
      "name: #{name}; field: #{field}; direction: #{direction}"
    end

    delegate :ascenders, :descenders, to: :orderer

    alias_method :asc, :ascenders
    alias_method :desc, :descenders

    def mapped name
      case name.to_sym
      when :published_at
        :date
      else
        name.to_sym
      end
    end    

    def field_name name
      case name.to_sym
      when :date
        :published_at
      else
        name.to_sym
      end
    end    

    def orderer
      @orderer ||= Property::Sorter.new field
    end
  end
end