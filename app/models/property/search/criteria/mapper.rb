# Use min max ranges from locale file
class Property::Search::Criteria
  class Mapper
    attr_reader :type, :criteria_hash

    class << self
      def build criteria_hash, preferences = nil, type = :ranges
        raise ArgumentError, "Invalid Mapper type: #{type}, must be one of: #{valid_types}" unless valid_type? type
        raise ArgumentError, "Must be a #{pref_clazz}, was: #{preferences}" unless valid_preferences? preferences
        raise ArgumentError, "Must be a Hash, was: #{criteria_hash}" unless criteria_hash.kind_of?(Hash)

        "Property::Search::Criteria::Mapper::#{clazz(type)}".new criteria_hash, preferences
      end

      def valid_type? type
        valid_types.include? type.to_s
      end

      def valid_preferences? preferences
        !preferences || preferences.kind_of?(pref_clazz)
      end

      def pref_clazz
        Property::Search::Criteria::Preferences
      end

      protected

      def valid_types
        %w{ranges simple}
      end

      def clazz type
        type.to_s.camelize
      end
    end
  end
end