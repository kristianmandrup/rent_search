class Property::Search::Criteria::Builder
  class ListCriteria < Base
    def criteria_for value
      {"$in" => value }
    end
  end
end