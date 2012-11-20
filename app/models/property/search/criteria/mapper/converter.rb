class Property::Search::Criteria::Mapper
  class Converter
    attr_reader :text

    include_concern :expressions, for: 'Property::Search::Criteria::Mapper'

    def initialize text
      @text = text
    end

    # TODO: clean up!
    def convert
      if text.to_s =~ or_expr
        txt = text.sub(sub_or_expr, ',')
        txt.split(',').map(&:to_i)
      else
        text
      end
    end

    def or_expr
      /\d.*\s#{expr_txt :or}\s.*\d/i
    end

    def sub_or_expr
      /\s#{expr_txt :or}\s/i
    end
  end
end