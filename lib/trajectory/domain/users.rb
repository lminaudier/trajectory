module Trajectory
  class Users < SimpleDelegator
    alias :users :__getobj__

    def initialize(*args)
      super(args)
    end
  end
end
