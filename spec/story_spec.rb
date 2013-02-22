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

    it 'knows when it is started' do
      Story.new(state: :started).should be_started
      Story.new(state: :unstarted).should_not be_started
    end
  end
end
