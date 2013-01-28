class Property::Search < BaseSearch
  class Criteria::Builder
    class TimespanCriteria < Base
      def set_criteria criteria_hash, field, value
        # puts "set_criteria: #{field}, #{value}"
        c = creator(field, value)
        criteria_hash[c.start_path] = {'$gte' => c.start_secs }
        criteria_hash[c.end_path]   = {'$lte' => c.end_secs }
        criteria_hash
      end    

      protected

      def creator field, value
        Creator.new self, field, value
      end

      class Creator
        include_concerns :mapper, for: 'Property::Search::Criteria::Builder'

        attr_reader :criteria_builder, :field, :value

        def initialize criteria_builder, field, value
          @criteria_builder = criteria_builder
          @field, @value = [field, value]
        end

        def start_secs
          value.start_date.to_i
        end

        def end_secs
          value.end_date.to_i
        end

        def start_path
          "#{criteria_field}.#{period_field}.#{TimeSpan.start_field}"
        end

        def end_path
          "#{criteria_field}.#{period_field}.#{TimeSpan.end_field}"
        end

        protected

        # delegate to builder Search class?
        def period_field
          :period
        end

        def criteria_field
          @criteria_field ||= criteria_field_name(field)
        end
      end
    end
  end
end