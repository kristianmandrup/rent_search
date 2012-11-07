class Property::Search::Criteria
  class Filter
    attr_reader :searcher

    # returned by searcher
    def initialize searcher
      unless searcher.kind_of?(Property::Searcher)
        raise ArgumentError, "Must be created with a Property::Searcher"
      end

      @searcher = searcher
    end

    def counts_for hash
      hash.keys.inject({}) do |res, key|
        res.merge! send("count_#{key}", hash[key])
      end
    end

    def all
      range_criterias.merge(enum_criterias).merge(select_criterias)
    end

    def search
      @search ||= searcher.execute
    end

    %w{range enum select}.each do |name|
      define_method "#{name}_counter" do
        counter[name] ||= "Property::Criteria::Filter::#{name.to_s.camelize}Counter".constantize.new search
      end

      delegate "#{name}_criterias", to: "#{name}_counter"
    end

    delegate :count_selects, to: :select_counter
    delegate :count_enums, to: :enum_counter
    delegate :count_ranges, to: :range_counter

    protected

    def counter
      @counter ||= {}
    end
  end
end