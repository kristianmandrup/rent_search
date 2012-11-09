class Search::Sorter
  module Displayer
    extend ActiveSupport::Concern

    # returns a sorting string in the form
    #   sort_field::sort_direction 
    # OR 
    #   sort_direction::sort_field
    def to_s
      send("#{parser_type}_arr").join(separator)    
    end

    protected

    def dir_field_arr
      [sort_direction, sort_field]
    end

    def field_dir_arr
      [sort_field, sort_direction]
    end
  end
end