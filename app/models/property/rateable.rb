class Property
  module Rateable
    extend ActiveSupport::Concern    
    include Mongoid::Rateable

    included do
      set_rating_range (1..5)

      rateable_by User
    end

    def favorite! user
      self.rate 1, user
    end

    def unfavorite! user
      self.unrate user
    end    
  end
end
