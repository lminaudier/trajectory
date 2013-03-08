module Trajectory
  class Updates
    attr_reader :stories, :iterations

    def initialize(stories, iterations)
      @stories = stories
      @iterations = iterations
    end
  end
end
