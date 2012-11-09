module Property::Search::Fields   
  module Validations
    extend ActiveSupport::Concern

    included do
      validates :radius,       inclusion:   {in: 1..50 }
      # location can be any string
      validates :types,        array:       {in: Property::Type.valid_values }
      validates :furnishment,  inclusion:   {in: Property::Furnishment.valid_values }
      validates :rooms,        range:       {within: 1..10 }
      validates :size,         range:       {within: 5..1000 }
      validates :cost,         range:       {within: 0..40000 }
      validates :rating,       range:       {within: 0..5 }
      validates :rentability,  range:       {within: 0..3 }

      # if using: none, partial, full
      # validates :furnishment,  array:  {in: Property::Furnishment.valid_values }        
    end
  end
end