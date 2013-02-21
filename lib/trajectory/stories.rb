require 'delegate'

module Trajectory
  class Stories < SimpleDelegator
    alias :stories :__getobj__

    def initialize(*args)
      super(args)
    end
  end
end
