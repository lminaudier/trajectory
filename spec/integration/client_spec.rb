require 'spec_helper'

vcr_options = { :cassette_name => "client", :record => :new_episodes }
describe Trajectory::Client, :vcr => vcr_options do
  it 'raises an exceptions when environment variables are not set' do
    begin
      original_api_key = ENV['TRAJECTORY_API_KEY']
      original_account_keyword = ENV['TRAJECTORY_ACCOUNT_KEYWORD']
      ENV['TRAJECTORY_API_KEY'] = nil
      ENV['TRAJECTORY_ACCOUNT_KEYWORD'] = nil

      expect do
        Trajectory::Client.new
      end.to raise_error
    ensure
      ENV['TRAJECTORY_API_KEY'] = original_api_key
      ENV['TRAJECTORY_ACCOUNT_KEYWORD'] = original_account_keyword
    end
  end

  it 'is able to retrieve all projects of the user' do
    projects = Trajectory::Client.new.projects

    project_1 = Trajectory::Project.new(id: 15504817)

    projects.should == Trajectory::Projects.new(project_1)
  end

  it 'is able to retrive all stories of a given project' do
    project = Trajectory::Client.new.projects.first

    story_1 = Trajectory::Story.new(id: 15623694)
    story_2 = Trajectory::Story.new(id: 15623695)
    project.stories.should == Trajectory::Stories.new(story_1, story_2)
  end

  it 'is able to retrieve all iterations of a project' do
    project = Trajectory::Client.new.projects.first

    iteration_1 = Trajectory::Iteration.new(id: 16055704)
    iteration_2 = Trajectory::Iteration.new(id: 16057164)
    project.iterations.should == Trajectory::Iterations.new(iteration_1, iteration_2)
  end

  it 'is able to retrieve all ideas of a project' do
    project = Trajectory::Client.new.projects.first

    idea_1 = Trajectory::Idea.new(id: 15505355)
    idea_2 = Trajectory::Idea.new(id: 15505354)
    project.ideas.should == Trajectory::Ideas.new(idea_1, idea_2)
  end

  it 'is able to retrieve all users of a project' do
    project = Trajectory::Client.new.projects.first

    user_1 = Trajectory::User.new(id: 15506817)
    project.users.should == Trajectory::Users.new(user_1)
  end

  it 'is able to retrieve all updates of a project' do
    current_date = DateTime.new(2013, 1, 1, 0, 0, 0)

    Timecop.freeze(current_date) do
      project = Trajectory::Client.new.projects.first

      iteration_1 = Trajectory::Iteration.new(id: 16055704)
      iteration_2 = Trajectory::Iteration.new(id: 16057164)
      iteration_3 = Trajectory::Iteration.new(id: 16063751)

      story_1 = Trajectory::Story.new(id: 15623694)
      story_2 = Trajectory::Story.new(id: 15623695)

      project.updates(since: current_date).iterations.should == Trajectory::Iterations.new(iteration_1, iteration_2, iteration_3)
      project.updates(since: current_date).stories.should == Trajectory::Stories.new(story_1, story_2)
    end
  end

  it 'creates association from iteration to project' do
    project = Trajectory::Client.new.projects.first
    iteration = project.iterations.first
    iteration.project.should == project
  end

  it 'creates association from story to project' do
    project = Trajectory::Client.new.projects.first
    story = project.stories.first

    story.project.should == project
  end

  it 'creates association from idea to project' do
    project = Trajectory::Client.new.projects.first
    idea = project.ideas.first
    idea.project.should == project
  end
end
