class Property::Search::Criteria::Filter
  class FieldSelector
    attr_reader :property_list

    include Enumerable

    def initialize property_list
      raise ArgumentError, "Must be a list" unless property_list.to_a.kind_of?(Array)
      @property_list = property_list.to_a
    end

    def each
      property_list.each {|prop| yield prop }
    end

    # which boolean fields are selected (true)
    def selected_fields *names
      names.flatten.map{|name| selected_field?(name) }.compact
    end

    def selected_field? name
      to_a.flatten.each do |item|
        return name if item.send(name)
      end
      nil
    end

    def values_for *names            
      names.flatten.inject({}) {|res, name| res.merge! name.to_sym => values_for_field(name) }
    end

    def values_for_field name
      raise ArgumentError, "Unknown field #{name} for #{first}" unless first.respond_to? name

      to_a.map{|item| item.send(name) }.compact.uniq
    end
  end
end