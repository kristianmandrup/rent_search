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

    # TODO: Use global config
    def valid_country_code? country_code
      valid_country_codes.include? country_code
    end

    def type= value
      self.rooms = nil if value.to_s == 'room'
      super(value)
    end

    def size= value
      val = value.kind_of?(Range) ? value : criteria_default(:size)
      write_attribute :size, val
    end

    def rooms= value
      val = value.kind_of?(Range) ? value : criteria_default(:rooms)
      # puts "set rooms: #{value} -> #{val}"
      write_attribute :rooms, val
    end

    def period= value
      val = value.kind_of?(Timespan) ? value : criteria_default(:period)
      write_attribute :period, val
    end

    def total_rent= value
      val = value.kind_of?(Range) ? value : criteria_default(:total_rent)
      write_attribute :total_rent, val
    end

    def full_address= value
      self.point = use_default_point?(value) ? criteria_default(:point) : calc_point(value)
    end

    def radius= value
      val = value.kind_of?(Fixnum) ? value : criteria_default(:radius)
      write_attribute :radius, val
    end

    protected

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

    def criteria_default name
      self.class.criteria_default name
    end
  end
end