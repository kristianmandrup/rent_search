class Property::Search::Preferences
  module Validator
    def valid_preferences? preferences
      !preferences || preferences.kind_of?(preferences_clazz)
    end

    def preferences_clazz
      Property::Search::Criteria::Preferences
    end
  end
end
