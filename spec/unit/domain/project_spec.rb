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
      stories = Stories.new(double(:story, :points => 2),
                            double(:story, :points => 10),
                            double(:story, :points => 8))
      DataStore.stub(:stories_for_project).and_return(stories)

      Project.new.total_points.should == 20
    end

    it 'can evaluate remaining iterations until project completion based on the last non nul velocity' do
      stories = Stories.new(double(:story, :points => 2, :completed? => false),
                            double(:story, :points => 10, :completed? => false),
                            double(:story, :points => 8, :completed? => true))
      DataStore.stub(:stories_for_project).and_return(stories)

      Project.new(:estimated_velocity => 2).remaining_iterations.should == 6
    end

    it 'can evaluate remaining points' do
      stories = Stories.new(double(:story, :points => 2, :completed? => false),
                            double(:story, :points => 10, :completed? => false),
                            double(:story, :points => 8, :completed? => true))
      DataStore.stub(:stories_for_project).and_return(stories)

      Project.new.remaining_points.should == 12
    end

    it 'can evaluate the number of days to the end' do
      stories = Stories.new(double(:story, :points => 2, :completed? => false),
                            double(:story, :points => 10, :completed? => false),
                            double(:story, :points => 8, :completed? => false))
      DataStore.stub(:stories_for_project).and_return(stories)

      project = Project.new(:estimated_velocity => 20)

      project.remaining_days.should == 7
    end

    it 'can evaluate project end date' do
      stories = Stories.new(double(:story, :points => 20, :completed? => false),
                            double(:story, :points => 10, :completed? => false),
                            double(:story, :points => 10, :completed? => false))
      DataStore.stub(:stories_for_project).and_return(stories)

      project = Project.new(:estimated_velocity => 20)

      project.estimated_end_date.should == Date.today + 14
    end

    it 'can evaluate velocity per day' do
      Project.new(:estimated_velocity => 20).estimated_velocity_per_day.should == 20 / 7.0
      Project.new(:estimated_velocity => 21).estimated_velocity_per_day.should == 21 / 7.0
      Project.new(:estimated_velocity => 7).estimated_velocity_per_day.should == 7 / 7.0
    end

    it 'can count the number of remaining working days' do
      stories = Stories.new(double(:story, :points => 2, :completed? => false),
                            double(:story, :points => 10, :completed? => false),
                            double(:story, :points => 8, :completed? => false))
      DataStore.stub(:stories_for_project).and_return(stories)

      project = Project.new(:estimated_velocity => 20)

      project.remaining_working_days.should == 5
    end

    it 'can estimate velocity per working day' do
      Project.new(:estimated_velocity => 20).estimated_velocity_per_working_day.should == 20 / 5.0
      Project.new(:estimated_velocity => 21).estimated_velocity_per_working_day.should == 21 / 5.0
      Project.new(:estimated_velocity => 7).estimated_velocity_per_working_day.should == 7 / 5.0
    end

    it 'can estimate the percentage of completion' do
      stories = Stories.new(double(:story, :points => 1, :completed? => false),
                            double(:story, :points => 10, :completed? => false),
                            double(:story, :points => 9, :completed? => true))
      DataStore.stub(:stories_for_project).and_return(stories)

      Project.new.percent_complete.should == 45.0
    end

    it 'can return the sum of completed stories points' do
      stories = Stories.new(double(:story, :points => 1, :completed? => false),
                            double(:story, :points => 10, :completed? => true),
                            double(:story, :points => 9, :completed? => true))
      DataStore.stub(:stories_for_project).and_return(stories)

      Project.new.accepted_points.should == 19
    end

    it 'can retrieve the last non null velocity in its history' do
      Project.new(:historic_velocity => [20, 0, 2, 3, 0, 0, 0]).last_non_null_velocity.should == 3
      Project.new(:historic_velocity => [0, 0, 20, 0, 2, 3, 0, 0, 0]).last_non_null_velocity.should == 3
      Project.new(:historic_velocity => [0, 0, 20, 0, 2, 3]).last_non_null_velocity.should == 3
    end

    it 'raises an error when trying to get last non null velocity of a project that not have yet started' do
      project = Project.new
      project.stub(:has_started?).and_return(false)

      expect do
        project.last_non_null_velocity
      end.to raise_error(VelocityAlwaysEqualToZero)
    end

    it 'can tell if a project has started based on historic velocity' do
      Project.new(:historic_velocity => [0, 0, 20, 0, 2, 3]).should have_started
      Project.new(:historic_velocity => [0, 0, 0, 0]).should_not have_started
      Project.new(:historic_velocity => []).should_not have_started
    end

    it 'delegates fetching of iterations of a project to the data store' do
      DataStore.should_receive(:iterations_for_project).with(project)

      project.iterations
    end

    it 'delegates fetching of updates of a project to the data store' do
      since = double
      DataStore.should_receive(:updates_for_project).with(project, since)

      project.updates(since)
    end

    it 'delegates fetching of ideas of a project to the data store' do
      DataStore.should_receive(:ideas_for_project).with(project)

      project.ideas
    end

    it 'can get stories of a given iteration' do
      stories = double
      iteration = double

      project.stories = stories
      stories.should_receive(:in_iteration).with(iteration)

      project.stories_in_iteration(iteration)
    end

    it 'can get one of its user by id' do
      users = double

      project.users_collection = users
      users.should_receive(:find_by_id).with(1234)

      project.find_user_by_id(1234)
    end

    it 'can get one of its iteration by id' do
      iterations = double

      project.iterations_collection = iterations
      iterations.should_receive(:find_by_id).with(1234)

      project.find_iteration_by_id(1234)
    end

    context 'when estimated velocity is zero' do
      it 'cannot estimate remaining days until the project end' do
        expect do
          Project.new(:estimated_velocity => 0).remaining_days
        end.to raise_error(VelocityEqualToZeroError)
      end

      it 'cannot estimate remaining working days until the project end' do
        expect do
          Project.new(:estimated_velocity => 0).remaining_working_days
        end.to raise_error(VelocityEqualToZeroError)
      end
    end
  end
end
