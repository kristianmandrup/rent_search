class Searcher
  class Options
    attr_reader :paged, :ordered

    # Used to configure the Searcher
    # Usage
    # => Searcher::Options.new :ordered, :paged
    #
    def initialize *options
      @options  = options.flatten      
    end

    # Create and return default Searcher options
    def self.create_default
      self.new
    end

    def paged
      @paged ||= enabled? :paged, :page
    end
    alias_method :paged?, :paged
    alias_method :page?, :paged

    def ordered
      @ordered ||= enabled? :ordered, :order, :sorted, :sort
    end
    alias_method :sorted, :ordered
    
    alias_method :ordered?, :ordered    
    alias_method :sort?, :ordered
    alias_method :sorted?, :ordered

    protected

    def enabled? *names
      !(options & names.flatten).empty?
    end
  end
end
