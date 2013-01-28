class Property::Search < BaseSearch
  class Criteria::Builder
    class ListCriteria < Base
      def criteria_for value
        {"$in" => value }
      end
    end
  end
end