class Property::Search::Criteria::Mapper
  class Simple < Base
    protected

    include Maps
    extend Maps    

    def map_value key, value
      return nil if !value || value == 'any' || value.blank?
      case key.to_sym
      when :type
        return nil unless types.include?(value.to_s)
        value
      when :furnishment
        return nil unless furnishments.include?(value.to_s)
        value
      when :total_rent, :cost, :rent, :total_cost
        cost_map[value.to_i]
      else
        map_meth = "#{key}_map"
        if respond_to? map_meth
          mapper = send(map_meth)
          index = value.to_i
          map_size = mapper.send(:size)
          if map_size < index
            # raise ArgumentError, "Mapper #{mapper} does not have sufficient values for the index: #{index}"
            index = 0
          end
          return mapper.send(:[], index) 
        end
        value
      end
    end

    def size_map
      send("#{area_unit}_map")
    end

    def sqfeet_map
      sqm_map.map{|range| range.to_sqfeet }
    end

    def sqm_map
      room? ? room_sqm_map : property_sqm_map
    end
  end
end
