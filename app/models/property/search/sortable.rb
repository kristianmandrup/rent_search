class Property::Search
  module Sortable
    extend ActiveSupport::Concern

    # Stores the primary sorting field and sort direction of a search
    included do
      embeds_one :sort, class_name: 'Property::Search::Sort'
    end
  end
end
