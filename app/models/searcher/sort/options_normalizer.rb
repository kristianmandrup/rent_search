class Searcher
  module Sort
    class OptionsNormalizer
      attr_reader :args

      def initialize *args
        @args = args
      end

      def normalize
        options = case args.first
        when Hash
          options = args.first
        when Symbol, String
          field, direction = args

          # swap if needed
          if %w{asc desc}.include? field.to_s
            field, direction = direction, field
          end

          {field: field, direction: direction }
        else
          raise ArgumentError, "Invalid sorter args: #{args}"
        end
      end
    end
  end
end