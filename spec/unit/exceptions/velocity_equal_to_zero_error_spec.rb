require 'spec_helper'

module Trajectory
  describe VelocityEqualToZeroError do
    it 'can displays that velocity of a project is equal to zero' do
      project = double
      VelocityEqualToZeroError.new(project).to_s.should == "Estimated velocity of #{project.inspect} is equal to 0."
    end
  end
end
