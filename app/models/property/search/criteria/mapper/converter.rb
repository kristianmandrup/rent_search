class Property::Search::Criteria::Mapper
  class Converter
    attr_reader :text

    include_concern :expressions, for: 'Property::Search::Criteria::Mapper'

    def initialize text
      @text = text.trim
    end

    def convert
      return convert_number if number? 
      convert_or
    end

    # TODO: clean up!
    def convert_or
      if text.to_s =~ or_expr
        txt = text.sub(sub_or_expr, ',')
        txt.split(',').map(&:to_i)
      else
        text
      end
    end

    def number?
      text =~ /^\d+$/
    end

    def convert_number
      [text.to_i, text.to_i]
    end

    def or_expr
      /\d.*\s#{expr_txt :or}\s.*\d/i
    end

    def sub_or_expr
      /\s#{expr_txt :or}\s/i
    end
  end
end