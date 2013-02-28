require 'spec_helper'

module Trajectory
  describe Iteration do
    let(:iteration) { Iteration.new(id: 42) }

    it 'can be initialized with named parameters' do
      iteration.id.should == 42
    end

    it 'requires an id attribute' do
      expect do
        Iteration.new.id
      end.to raise_error(MissingAttributeError)
    end

    it 'is the same story when ids are the same' do
      iteration.should == Iteration.new(id: 42)
    end

    it 'knows when the iteration is a past one' do
      Iteration.new(:complete => true).past?.should == true
      Iteration.new(:complete => false).past?.should == false
    end

    it 'knows when the iteration is a future one' do
      Iteration.new(:complete => true, :current => true).future?.should == false
      Iteration.new(:complete => true, :current => false).future?.should == false
      Iteration.new(:complete => false, :current => true).future?.should == false
      Iteration.new(:complete => false, :current => false).future?.should == true
    end

    context 'it has attributes accessors' do
      %w(percent_complete started_stories_count created_at estimated_velocity delivered_stories_count updated_at unstarted_stories_count starts_on current stories_count id complete accepted_points estimated_points comments_count accepted_stories_count).each do |attribute|
        it "'#{attribute}' accessor" do
          Iteration.new.should respond_to(attribute.to_sym)
        end
      end
    end

    it 'delegates fetching of its stories to its project' do
      project = double
      iteration = Fabricate(:iteration)
      iteration.project = project

      project.should_receive(:stories_in_iteration).with(iteration)

      iteration.stories
    end
  end
end
