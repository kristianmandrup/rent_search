class Search
  class History
    attr_reader :stack

    def initialize size = 10
      @stack = unique_fifo_stack(size)
    end

    delegate :push, :all, :empty?, :full?, :last, :reset, :size, :current_size, to: :stack

    alias_method :max_size, :size
  end
end
