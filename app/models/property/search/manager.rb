class Property
  class Search
    class Manager < ::Search::Manager
      def initialize  user, storage = nil
        super
      end

      def search_class
        Property::Search
      end
    end
  end
end
