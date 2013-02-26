module Trajectory
  class Iterations < SimpleDelegator
    alias :stories :__getobj__

    def initialize(*args)
      super(args)
    end

    def current
      detect(&:current?)
    end
  end
end
