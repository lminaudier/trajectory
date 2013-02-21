require 'spec_helper'

describe Trajectory::Client do
  it 'is able to retrieve all projects of the user' do
    VCR.use_cassette('projects') do
      projects = Trajectory::Client.new.projects

      project_1 = Trajectory::Project.new(id: 15504817)

      projects.should == Trajectory::Projects.new(project_1)
    end
  end

  it 'is able to retrive all stories of a given project' do
    VCR.use_cassette('projects_and_stories') do
      project = Trajectory::Client.new.projects.first

      story_1 = Trajectory::Story.new(id: 15623694)
      story_2 = Trajectory::Story.new(id: 15623695)
      project.stories.should == Trajectory::Stories.new(story_1, story_2)
    end
  end

  it 'creates association from story to project' do
    VCR.use_cassette('projects_and_stories') do
      project = Trajectory::Client.new.projects.first
      story = project.stories.first

      story.project.should == project
    end
  end
end
