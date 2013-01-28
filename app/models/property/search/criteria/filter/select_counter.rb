class Property::Search < BaseSearch
  class Criteria::Filter
    class SelectCounter < FieldCounter
      def count_selects *fields
        select_criterias(*fields)[:selected].inject({}) do |res, enum|
          res.merge! enum => search.where(enum => true).to_a.size
        end
      end

      # TODO: fix caching!
      def select_criterias *fields
        fields = select_fields if fields.empty?
        @select_criterias ||= {:selected => selected_fields(fields) }
      end

      def select_fields
        %w{parking washing_machine} #.map(&:to_sym)
      end
    end
  end
end