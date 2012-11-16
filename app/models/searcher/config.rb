class Searcher
  module Config
    extend ActiveSupport::Concern
    
    def normalize_options options = {}
      return default_options if options.empty?
      
      case options
      when Symbol, Array
        options = Searcher::Options.new options
      when Hash
        options = Searcher::Options.create_from(options) 
      when Searcher::Options
        options
      else
        raise ArgumentError, "Not a valid Searcher::Options, was: #{options}"
      end
    end

    def default_options
      Searcher::Options.create_default
    end
  end
end