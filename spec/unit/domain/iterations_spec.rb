require 'spec_helper'

module Trajectory
  describe Iterations do
    it 'can be initializes from a json array of components attributes' do
      project = double(:project, :id => 4567)
      json_iterations_collection = [{'id' => 1234, 'estimated_points' => 12}, {'id' => 42, 'estimated_points' => 10}]

      iterations = Iterations.from_json project, json_iterations_collection

      iterations.should be_kind_of(Iterations)
      iterations.first.id.should == 1234
      iterations.first.estimated_points.should == 12

      iterations[1].id.should == 42
      iterations[1].estimated_points.should == 10

      iterations.first.project_id.should == 4567
      iterations[1].project_id.should == 4567
    end

    it 'can find an iteration by id' do
      iteration = double(:iteration, id: 1234)
      iterations = Iterations.new(double(:iteration, id: 1),
                 double(:iteration, id: 2),
                 iteration,
                 double(:iteration, id: 3))

      iterations.find_by_id(1234).should == iteration
    end

    it "returns false when it can't find a project by id" do
      iterations = Iterations.new(double(:iteration, id: 1),
                              double(:iteration, id: 2),
                              double(:iteration, id: 3))

      iterations.find_by_id(1234).should == false
    end

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
