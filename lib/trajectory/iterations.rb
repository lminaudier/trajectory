module Trajectory
  class Iterations < SimpleDelegator
    alias :stories :__getobj__

    def initialize(*args)
      super(args)
    end
  end
end
