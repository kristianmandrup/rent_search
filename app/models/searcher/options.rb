class Searcher
  class Options
    attr_reader :paged, :ordered, :options

    # Used to configure the Searcher
    # Usage
    # => Searcher::Options.new :ordered, :paged
    #
    def initialize *options
      @options  = options.flatten      
    end

    def self.create_from hash
      options = hash.map{|(key, val)| key.to_sym if val == true }.compact
      self.new options
    end

    delegate :empty?, to: :options

    # TODO: Use proper filter?
    def only *names
      options & names.flatten
    end

    def except *names
      options & names.flatten
    end

    # Create and return default Searcher options
    def self.create_default
      self.new
    end

    def paged
      @paged ||= enabled? :paged, :page, :pager
    end
    alias_method :paged?, :paged
    alias_method :page?,  :paged
    alias_method :pager?, :paged

    def ordered
      @ordered ||= enabled? :ordered, :order, :sorted, :sort, :sorter
    end
    alias_method :sorted, :ordered
    
    alias_method :ordered?, :ordered    
    alias_method :sort?,    :ordered
    alias_method :sorted?,  :ordered
    alias_method :sorter?,  :ordered

    protected

    def enabled? *names
      !(options & names.flatten).empty?
    end
  end
end
