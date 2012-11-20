class Search
  class SortOrder
    attr_reader :name, :field, :direction
    attr_accessor :calculator_class

    # An incoming request to sort with a :name and :direction
    # The name can be mapped to a specific field_name
    #   date -> publish_date

    # TODO: use OptionsNormalizer
    def initialize *args
      options = options_normalizer(*args).normalize
      name = options[:field]
      direction = options[:direction]

      name       ||= default_field
      @name      = label name
      @field     = field_name(name) || default_field
      @direction = direction || default_direction   
    end

    def options_normalizer *args
      @options_normalizer ||= Searcher::Sort::OptionsNormalizer.new *args
    end    

    def valid?
      valid_direction?(direction) && valid_field?(field)
    end

    def valid_dir?
      valid_direction?(direction)
    end

    def valid_field_name?
      valid_field?(field)
    end

    # TODO: Should be possible to simplify all this!
    def calc!
      calculator.calc!
      self.field = calculator.field
      self.direction = calculator.direction
      self
    end
    alias_method :calc, :calc!

    def direction= dir
      raise ArgumentError, "Invalid direction: #{dir}" unless valid_direction? dir
      @direction = dir
    end

    def field= field
      raise ArgumentError, "Invalid field: #{field}" unless valid_field? field
      @field = field
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

    def allow_any_field?
      true
    end

    # or raise not implemented?
    def calculator_class
      @calculator_class ||= Search::SortOrder::Calculator
    end

    alias_method :sort_name,      :name 
    alias_method :sort_field,     :field
    alias_method :sort_direction, :direction

    delegate :default_field, :default_direction,  to: :calculator
    delegate :sort_fields,   :sort_fields_for,    to: :calculator
    delegate :valid_direction?, :valid_field?,    to: :calculator

    def calculator
      @calculator ||= calculator_class.new self
    end
  end
end