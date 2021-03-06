require 'spec_helper'

module Trajectory
  describe Story do
    let(:story) { Story.new(id: 42, title: 'foo') }

    it 'can be initialized with named parameters' do
      story.id.should == 42
      story.title.should == 'foo'
    end

    it 'requires an id attribute' do
      expect do
        Story.new.id
      end.to raise_error(MissingAttributeError)
    end

    it 'is the same story when ids are the same' do
      story.should == Story.new(id: 42, title: 'bar')
    end

    context 'it has attributes accessors' do
      %w(assignee_name task_type position created_at state_events title design_needed? updated_at idea_subject archived? points id development_needed? deleted? user_name comments_count state).each do |attribute|
        it "'#{attribute}' accessor" do
          Story.new.should respond_to(attribute.to_sym)
        end
      end
    end

    it 'delegates project fetching to data store' do
      DataStore.should_receive(:find_project_by_id)

      Story.new.project
    end

    it 'delegates iteration fetching to data store' do
      project = 1234
      story = Story.new(:iteration_id => 1234)
      story.stub(:project).and_return(project)

      DataStore.should_receive(:find_iteration_of_project_by_id).with(project, 1234)

      story.iteration
    end

    it 'knows when it is started' do
      Story.new(state: :started).should be_started
      Story.new(state: :unstarted).should_not be_started
    end

    it 'knows when it is unstarted' do
      Story.new(state: :unstarted).should be_unstarted
      Story.new(state: :started).should_not be_unstarted
    end

    it 'knows when a story is not completed' do
      %w(started unstarted delivered rejected).each do |state|
        Story.new(state: state).should be_not_completed
        Story.new(state: state).should_not be_completed
      end
      Story.new(state: :accepted).should_not be_not_completed
      Story.new(state: :accepted).should be_completed
    end

    it 'knows if it is included in an iteration' do
      iteration = double(:id => 42)
      Story.new(iteration_id: 42).should be_in_iteration(iteration)
      Story.new(iteration_id: 51).should_not be_in_iteration(iteration)
    end

    it 'delegates user fetching to data store' do
      project = double
      story = Story.new(user_id: 42)
      story.stub(:project).and_return(project)

      DataStore.should_receive(:find_user_of_project_with_id).with(project, 42)

      story.user
    end
  end
end
