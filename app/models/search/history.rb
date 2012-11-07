class Search
  class History
    attr_reader :stack

    def initialize size = 10
      @stack = fifo_stack(size)
    end

    delegate :push, :all, :empty?, :full?, :last, :reset, to: :stack

    def size
      stack.size
    end
    alias_method :max_size, :size
  end
end
