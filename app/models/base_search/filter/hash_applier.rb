class BaseSearch::Filter
  class HashApplier < Applier
    def hash; obj; end

    protected

    def allowed_classes
      [Hash]
    end
  end
end
