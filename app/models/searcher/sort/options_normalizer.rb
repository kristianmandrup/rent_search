class Searcher
  module Sort
    class OptionsNormalizer
      attr_reader :args

      def initialize *args
        @args = *args
      end

      def normalize
        @args.flatten! if args.first.kind_of?(Array)
        options = case args.first
        when NilClass
          nil
        when Hash
          hash = args.first
          hash.inject({}) do |h, (k, v)|
            h.merge! k => v.to_sym
          end  
        when Symbol, String
          field, direction = args

          # swap if needed
          if %w{asc desc}.include? field.to_s
            field, direction = direction, field
          end

          direction ||= :asc

          {field: field.to_sym, direction: direction.to_sym }
        else
          raise ArgumentError, "Invalid sorter args: #{args}"
        end
      end
    end
  end
end