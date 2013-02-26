require 'spec_helper'

module Trajectory
  describe Iterations do
    it 'can retrieve current iteration' do
      current_iteration = Fabricate(:iteration, current: true)
      iterations = Iterations.new(Fabricate(:iteration, current: false),
                                  current_iteration,
                                  Fabricate(:iteration, current: false))

      iterations.current.should == current_iteration
    end
  end
end
