module Search::Sorter
  # Can Swap direction and field name 
  # if the field name is accidentally the name of a valid direction
  
  module Swapper
    extend ActiveSupport::Concern

    # use this when sort_field for some reason has become a direction
    # and needs to be swapped
    def swap!
      @sort_field, @sort_direction = @sort_direction, @sort_field
    end

    # is this text a direction ?
    def direction? txt
      directions.include? txt.to_sym
    end

    def directions
      [:asc, :desc]
    end
  end
end