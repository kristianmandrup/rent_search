class Property::Search::Criteria::Mapper
  class Parser
    attr_reader :text

    include_concern :expressions, for: 'Property::Search::Criteria::Mapper'

    def initialize text
      @text = text
    end

    def range_arr
      @range_arr ||= a_range || more_than || less_than || more_or_eq_than || less_or_eq_than
    end

    def range
      @range ||= Range.new range_arr.first, range_arr.last
    end

    def valid?
      range_arr.kind_of?(Array) && !(range_arr.first == nil)
    end

    def a_range
      separators.map {|s| try_separator(s) }.compact.first
    end    

    def less_than
      parse_less if less_expr?
    end

    def less_or_eq_than
      parse_less_or_eq if less_or_eq_expr?
    end

    def more_than
      parse_more if more_expr?
    end

    def more_or_eq_than
      parse_more_or_eq if more_or_eq_expr?
    end

    # + or >
    def more_expr?
      text =~ /^\>\s*\d/ || text =~ text_expr(:more_than)      
    end

    def more_or_eq_expr?
      text =~ /^\+\s*\d/ || text =~ /\d\s*\+$/ || text =~ text_expr(:or_more, :after)
    end

    # - or <
    def less_expr?
      text =~ /^\<\s*\d/ || text =~ text_expr(:less_than)
    end

    def less_or_eq_expr?
      text =~ /^\-\s*\d/ || /\d\s*\-$/ ||  text =~ text_expr(:or_less, :after)     
    end

    def separators
      ['-', ':']
    end

    def try_separator separator
      text.split(separator).map(&:to_i) if text =~ sep_expr(separator)
    rescue Exception => e
      nil
    end

    def sep_expr separator
      /\d\s*#{separator}\s*\d/
    end

    def parse_more
      txt = text.sub(/^#{expr_txt :more_than}/i,'').sub(/\>/,'')
      [txt.to_i+1, 900000000]
    end    

    def parse_more_or_eq
      txt = text.sub(/#{expr_txt :or_more}/i,'')
      [txt.to_i, 900000000]
    end    

    def parse_less
      txt = text.sub(/^#{expr_txt :less_than}/i,'').sub(/\</,'')
      [0, txt.to_i-1]
    end    

    def parse_less_or_eq
      txt = text.sub(/#{expr_txt :or_less}/i,'').sub(/^-/, '')
      [0, txt.to_i]
    end        
  end
end