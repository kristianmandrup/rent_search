class Property::Search::Criteria::Builder
  class RangeCriteria < Base
    def criteria_for value
      return {} if value.nil?
      raise ArgumentError, "Must be a Range, was: #{value}" unless value.kind_of?(Range)
      {'$gte' => value.first, '$lte' => value.last}
    end
  end
end