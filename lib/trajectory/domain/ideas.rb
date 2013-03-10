module Trajectory
  class Ideas < SimpleDelegator
    alias :ideas :__getobj__

    # Creates a new collection of {Idea}
    #
    # @param ideas [Array<Idea>] a arbitrary lenght list of {Idea} objects
    def initialize(*ideas)
      super(ideas)
    end
  end
end
