class Property::Search < BaseSearch
  class Preferences
    module Validator
      def valid_preferences? preferences
        !preferences || preferences.kind_of?(preferences_clazz)
      end

      def preferences_clazz
        Property::Search::Preferences
      end
    end
  end
end