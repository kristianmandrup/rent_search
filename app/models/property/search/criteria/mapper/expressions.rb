class Property::Search::Criteria::Mapper
  module Expressions
    extend ActiveSupport::Concern

    def text_expr key, pos = :before
      pos == :before ? /^#{expr_txt key}\s*\d/i : /\d\s*#{expr_txt key}$/i      
    end

    def expr_txt key
      Regexp.escape(txt key)
    end

    def txt key
      I18n.translate! ['search.property.ranges.operators', key].join '.'
    rescue I18n::MissingTranslationData
      key.to_s.humanize
    end
  end
end