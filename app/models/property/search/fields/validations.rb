module Property::Search::Fields   
  module Validations
    extend ActiveSupport::Concern

    # Requires TypeMapping

    included do
      validates :radius,        allow_blank: true, inclusion:   {in: 1..50 }
      # location can be any string
      validates :types,         allow_blank: true, array:       {in: Property::Type.valid_values }
      validates :furnishment,   allow_blank: true, inclusion:   {in: Property::Furnishment.valid_values }
      validates :rooms,         array:       {in: (1..10) }

      validates :sqm,           allow_blank: true, range: {within: 5..1000 }
      validates :sqfeet,        allow_blank: true, range: {within: 5..1000 }
      
      validates :period,        timespan: {from: 1.month.ago, to: 2.years.from_now }

      validates :cost,          range: {within: 0..40000 }
      validates :rating,        range: {within: 0..5 }
      validates :rentability,   range: {within: 0..3 }

      # NOTE!!! if using: none, partial, full
      # validates :furnishment,   array:  {in: Property::Furnishment.valid_values }
    end
  end
end