module Trajectory
  class Iterations < SimpleDelegator
    alias :iterations :__getobj__

    def initialize(*args)
      super(args)
    end

    def current
      iterations.find { |iteration| iteration.current? } || false
    end
  end
end
