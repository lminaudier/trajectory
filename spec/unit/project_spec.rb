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

    it 'can evaluate remaining points' do
      stories = Stories.new(Fabricate(:story, :points => 2, :state => :started),
                            Fabricate(:story, :points => 10, :state => :unstarted),
                            Fabricate(:story, :points => 8, :state => :accepted))
      DataStore.stub(:stories_for_project).and_return(stories)

      Project.new.remaining_points.should == 12
    end

    it 'can evaluate the number of days to the end' do
      stories = Stories.new(Fabricate(:story, :points => 2, :state => :started),
                            Fabricate(:story, :points => 10, :state => :unstarted),
                            Fabricate(:story, :points => 8, :state => :unstarted))
      DataStore.stub(:stories_for_project).and_return(stories)

      project = Project.new(:estimated_velocity => 20)

      project.remaining_days.should == 7
    end

    it 'can evaluate project end date' do
      stories = Stories.new(Fabricate(:story, :points => 20, :state => :unstarted),
                            Fabricate(:story, :points => 10, :state => :unstarted),
                            Fabricate(:story, :points => 10, :state => :unstarted))
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
      stories = Stories.new(Fabricate(:story, :points => 2, :state => :started),
                            Fabricate(:story, :points => 10, :state => :unstarted),
                            Fabricate(:story, :points => 8, :state => :unstarted))
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
      stories = Stories.new(Fabricate(:story, :points => 1, :state => :started),
                            Fabricate(:story, :points => 10, :state => :unstarted),
                            Fabricate(:story, :points => 9, :state => :accepted))
      DataStore.stub(:stories_for_project).and_return(stories)

      Project.new.percent_complete.should == 45.0
    end

    it 'can return the sum of completed stories points' do
      stories = Stories.new(Fabricate(:story, :points => 1, :state => :started),
                            Fabricate(:story, :points => 10, :state => :accepted),
                            Fabricate(:story, :points => 9, :state => :accepted))
      DataStore.stub(:stories_for_project).and_return(stories)

      Project.new.accepted_points.should == 19
    end

    it 'delegates fetching of iterations of a project to the data store' do
      DataStore.should_receive(:iterations_for_project).with(project)

      project.iterations
    end

    it 'can get stories of a given iteration' do
      stories = double
      iteration = double

      project.stories = stories
      stories.should_receive(:in_iteration).with(iteration)

      project.stories_in_iteration(iteration)
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
