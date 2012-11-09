class Property::Searcher
  class Base < ::Searcher
    def initialize options = {}
      super
    end

    def search
      raise NotImplementedError, "Must be implemented by subclass"
    end
  end
end