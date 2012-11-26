module Property::Search::Fields
  module Setters
    extend ActiveSupport::Concern

    def shared= value
      boolean?(value) ? write_attribute(:shared, value) : unset(:shared)        
    end

    # TODO: Use global config
    def country_code= value
      value = default_country_code unless valid_country_code? value
      write_attribute :country_code, value
    end

    def location= value
      self.full_address = value
    end

    def location
      full_address
    end

    def period_from= from
    end

    def period_to= to
    end

    def period_from
    end

    def period_to
    end

    # TODO: Use global config
    def valid_country_code? country_code
      valid_country_codes.include? country_code
    end

    # If using: none, partial, full
    # def furnishment= value
    #   value = value.kind_of?(Array) ? value : [value]
    #   super(value)
    # end

    def types= value
      self.rooms = [1] if value == ['room']
      raise ArgumentError, "types must be an Array, was: #{value}" unless value.kind_of?(Array)
      super(value)
    end

    def type= value
      self.types = [value]
    end


    def size= value
      val = value.kind_of?(Range) ? value : default_value(:size)
      write_attribute :size, val
    end

    def rooms= value
      val = numeric_array?(value) ? value : default_value(:rooms)
      val = [1] if self.types == ['room']

      # raise ArgumentError, "Rooms must be convertible to a numeric Array, was: #{value}" unless numeric_array?(value)
      write_attribute :rooms, val.to_a
    end

    def period= value
      val = value.kind_of?(Timespan) ? value : default_value(:period)
      write_attribute :period, val
    end

    def total_rent= value
      val = value.kind_of?(Range) ? value : default_value(:total_rent)
      write_attribute :cost, val
    end
    alias_method :cost=, :total_rent=

    def full_address= value
      self.point = use_default_point?(value) ? default_value(:point) : calc_point(value)
    end

    def radius= value
      val = value.kind_of?(Fixnum) ? value : default_value(:radius)
      write_attribute :radius, val
    end

    protected

    def numeric_array? value
      return true if value.kind_of?(Range) && value.min >= 0
      return false unless value.kind_of?(Array)
      value.all?{|v| v.kind_of?(Fixnum) }
    end

    def boolean? value
      value.is_a?(TrueClass) || value.is_a?(FalseClass)
    end

    def valid_country_codes
      ['DK', 'SE']
    end

    def default_country_code
      valid_country_codes.first
    end

    def use_default_point? value
      value.blank? || value == 'any'
    end

    def default_value name
      self.class.default_value name
    end
  end
end