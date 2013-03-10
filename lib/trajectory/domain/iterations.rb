module Trajectory
  class Iterations < SimpleDelegator
    alias :iterations :__getobj__

    # Creates a new collection of {Iteration}
    #
    # @param iterations [Array<Iteration>] a arbitrary lenght list of {Iteration} objects
    def initialize(*iterations)
      super(iterations)
    end

    # Returns the current iteration of the project or false it no current iteration can be found
    #
    # @return [Iteration, false] the current iteration or false
    def current
      iterations.find { |iteration| iteration.current? } || false
    end

    # Returns the future iterations of the project
    #
    # @return [Iterations] the future iterations
    def future
      iterations.select { |iteration| iteration.future? }
    end

    # Returns the past iterations of the project
    #
    # @return [Iterations] the past iterations
    def past
      iterations.select { |iteration| iteration.past? }
    end
  end
end
