module Trajectory
  class Ideas < SimpleDelegator
    alias :ideas :__getobj__

    def initialize(*args)
      super(args)
    end
  end
end
