class Searcher
  module ConfigOptions
    extend ActiveSupport::Concern
    
    def normalize_options searcher_options
      if searcher_options.kind_of?(Array)
        searcher_options = Searcher::Options.create_from(searcher_options) 
      end
      searcher_options ||= Searcher::Options.create_default
      validate_options! searcher_options
    end

    def validate_options! searcher_options
      unless searcher_options.kind_of?(Searcher::Options)
        raise ArgumentError, "Not a valid Searcher::Options, was: #{searcher_options}"
      end
    end
  end
end