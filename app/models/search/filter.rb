class Search
  class Filter
    attr_reader :filter

    def initialize filter_options = {}
      only filter_options[:only]
      except filter_options[:except]
    end

    def applier_for subject
      case subject
      when Hash
        hash_applier(subject)
      when Mongoid::Document
        applier(subject)
      else
        raise ArgumentError, "No Filter Applier exists for: #{subject}. Try a Hash or a Mongoid::Document"
      end
    end

    def only *filter
      @only_filter = filter.flatten
    end

    def except *filter
      @except_filter = filter.flatten
    end

    protected

    def hash_applier hash
      HashApplier.new self, hash
    end

    def applier doc
      Applier.new self, doc
    end
  end
end
