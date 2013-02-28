module Trajectory
  class Iterations < SimpleDelegator
    alias :iterations :__getobj__

    def initialize(*args)
      super(args)
    end

    def current
      iterations.find { |iteration| iteration.current? } || false
    end

    def future
      iterations.select { |iteration| iteration.future? }
    end

    def past
      iterations.select { |iteration| iteration.past? }
    end
  end
end
