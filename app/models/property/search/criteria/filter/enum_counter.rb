class Property::Search::Criteria::Filter
  class EnumCounter < FieldCounter
    def count_enums *args
      return count_enums_for(args.first) if args.first.kind_of?(Hash)
      
      enum_criterias(*args).inject({}) do |res, (key, list)|
        hash = {key => {}}
        list = [list] unless list.kind_of?(Array)
        list.each do |enum|
          hash[key].merge!(enum => search.where(key => enum).to_a.size)
        end
        res.merge! hash
      end
    end

    def count_enums_for enum_hash
      keys = enum_hash.keys
      enum_criterias(keys).inject({}) do |res, (key, list)|
        hash = {}
        if keys.include?(key)
          hash.merge! key => {}
          list = [list] unless list.kind_of?(Array)
        
          list.each do |enum|
            values = enum_hash[key]
            if !values || values.include?(enum)
              hash[key].merge!(enum => search.where(key => enum).to_a.size)
            end
          end
        end
        res.merge! hash
      end
    end

    # TODO: fix caching!
    def enum_criterias *fields
      fields = enum_fields if fields.empty?
      @enum_criterias ||= values_for(fields)
    end        

    def enum_fields
      %w{type furnishment} #.map(&:to_sym)
    end
  end
end
