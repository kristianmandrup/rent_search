class Property::Search < BaseSearch
  class Preferences
    include ActiveModel::Validations

    attr_reader :area_unit, :currency

    def initialize options = {}
      @area_unit = options[:area_unit] || default_area_unit
      @currency = options[:currency] || default_currency
    end

    def self.create_default
      self.new
    end

    validates :area_unit, presence: true
    validates :currency, presence: true

    def area_unit= unit
      unless valid_area_units.include? unit
        raise ArgumentError, "Not a valid area unit, was: #{unit}, must be one of #{valid_area_units}" 
      end
      @area_unit = unit
    end      

    def currency= currency
      unless valid_currencies.include? currency
        raise ArgumentError, "Not a valid currency, was: #{currency}, must be one of #{valid_currencies}" 
      end
      @currency = currency
    end   

    protected

    def default_area_unit
      'sqm'   
    end

    def default_currency
      'EUR'   
    end

    module Methods
      def valid_area_units
        %w{sqm sqfeet}
      end

      def valid_money_units
        %w{EUR USD DKK}
      end
    end
    include Methods
    extend Methods
  end
end
