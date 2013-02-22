require 'delegate'

module Trajectory
  class Stories < SimpleDelegator
    alias :stories :__getobj__

    def initialize(*args)
      super(args)
    end

    def started
      stories.select(&:started?)
    end

    def unstarted
      stories.select(&:unstarted?)
    end
  end
end
