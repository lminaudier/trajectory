module Trajectory
  class VelocityEqualToZeroError < RuntimeError
    def initialize(project)
      @project = project
    end

    def to_s
      "Estimated velocity of #{@project.inspect} is equal to 0."
    end
  end
end
