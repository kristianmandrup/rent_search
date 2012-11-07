class Property::Search::Criteria::Builder
  class ListCriteria < Base
    def criteria_for value
      {'$gte' => value.first, '$lte' => value.last}
    end
  end
end
