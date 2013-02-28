require 'spec_helper'

module Trajectory
  describe Iterations do
    it 'can retrieve current iteration' do
      current_iteration = double(:current? => true)
      iterations = Iterations.new(double(:current? => false),
                                  current_iteration,
                                  double(:current? => false))

      iterations.current.should == current_iteration
    end

    it 'can retrieve pasts iterations' do
      past_iteration_1 = double(:past? => true)
      past_iteration_2 = double(:past? => true)
      iterations = Iterations.new(past_iteration_1, double(:past? => false), double(:past? => false), past_iteration_2)

      iterations.past.should == Iterations.new(past_iteration_1, past_iteration_2)
    end

    it 'can retrieve future iterations' do
      future_iteration_1 = double(:future? => true)
      future_iteration_2 = double(:future? => true)
      iterations = Iterations.new(future_iteration_1, double(:future? => false), double(:future? => false), future_iteration_2)

      iterations.future.should == Iterations.new(future_iteration_1, future_iteration_2)
    end
  end
end
