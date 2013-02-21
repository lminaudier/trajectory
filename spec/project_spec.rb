require 'spec_helper'

module Trajectory
  describe Project do
    let(:project) { Project.new(id: 42, name: 'foo') }

    it 'can be initialized with named parameters' do
      project.id.should == 42
      project.name.should == 'foo'
    end

    it 'requires an id attribute' do
      expect do
        Project.new.id
      end.to raise_error(MissingAttributeError)
    end

    it 'is the same project when ids are the same' do
      project.should == Project.new(id: 42, name: 'bar')
    end

    context 'it has attributes accessors' do
      %w(archived? created_at estimated_velocity historic_velocity id keyword updated_at completed_iterations_count completed_stories_count).each do |attribute|
        it "'#{attribute}' accessor" do
          Project.new.should respond_to(attribute.to_sym)
        end
      end
    end

    it 'can sum the points of all its stories' do
      stories = Stories.new(Fabricate(:story, :points => 2),
                            Fabricate(:story, :points => 10),
                            Fabricate(:story, :points => 8))
      DataStore.stub(:stories_for_project).and_return(stories)

      Project.new.total_points.should == 20
    end
  end
end

