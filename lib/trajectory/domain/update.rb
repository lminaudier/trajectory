module Trajectory
  class Update
    # @attr_reader stories [Stories] the updated stories by the update
    # @attr_reader iterations [iterations] the updated iterations by the update
    attr_reader :stories, :iterations

    # Creates a new update with given updated stories and iterations
    def initialize(stories, iterations)
      @stories = stories
      @iterations = iterations
    end
  end
end
