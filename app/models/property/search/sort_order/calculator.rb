class Property::Search::SortOrder
  class Calculator < ::Search::SortOrder::Calculator
    def default_sort_order
      :published_at
    end

    # Retrieve from YAML file
    # %w{date published_at cost cost_sqm rentability}
    def asc_fields
      @asc_fields ||= fields_for :asc
    end

    # Retrieve from YAML file
    # %w{rating sqm rooms}
    def desc_fields
      @desc_fields ||= fields_for :desc
    end

    protected

    # dir can be :asc or desc
    def fields_for dir
      dir = dir.to_sym
      raise ArgumentError, "Must be :asc or :desc" unless [:asc, :desc].include? dir
      @ascenders ||= I18n.t('property.sort.options').inject([]) do |res, pair|
        res << pair.first if pair.last[dir]
        res
      end
    end    
  end
end