class Search
  class Filter
    attr_reader :only_filter, :except_filter

    def initialize filter_options = {}
      only filter_options[:only]
      except filter_options[:except]
    end

    def apply_on subject
      applier_for(subject).apply
    end

    def applier_for subject
      case subject
      when Hash
        hash_applier(subject)
      when Mongoid::Document
        search_applier(subject)
      else
        raise ArgumentError, "No Filter Applier exists for: #{subject}. Try a Hash or a Mongoid::Document"
      end
    end

    def to_s
      %Q{
only:   #{only_filter}
except: #{except_filter}
}
    end

    def only *filter
      @only_filter = filter.flatten.compact
    end

    def except *filter
      @except_filter = filter.flatten.compact
    end

    protected

    def hash_applier hash
      HashApplier.new self, hash
    end

    def search_applier doc
      SearchApplier.new self, doc
    end
  end
end
