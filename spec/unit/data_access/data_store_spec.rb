require 'spec_helper'

module Trajectory
  describe DataStore do
    before(:each) do
      DataStore.instance_variable_set(:@projects, nil)
    end

    it 'maps JSON projects to actual collection of projects' do
      json_projects_collection = double
      Api.stub(:projects).and_return(json_projects_collection)
      Projects.should_receive(:from_json).with(json_projects_collection)

      DataStore.projects
    end

    let(:project) { double(:project, :id => 4567) }

    it 'maps JSON users to actual collection of users' do
      json_users_collection = double
      Api.stub(:users_for_project).and_return(json_users_collection)
      Users.should_receive(:from_json).with(json_users_collection)

      DataStore.users_for_project(project)
    end

    it 'maps JSON stories to actual collection of stories' do
      json_stories_collection = double
      Api.stub(:stories_for_project).and_return(json_stories_collection)
      Stories.should_receive(:from_json).with(project, json_stories_collection)

      DataStore.stories_for_project(project)
    end

    it 'maps JSON iterations to actual collection of iterations' do
      json_iterations_collection = double
      Api.stub(:iterations_for_project).and_return(json_iterations_collection)
      Iterations.should_receive(:from_json).with(project, json_iterations_collection)

      DataStore.iterations_for_project(project)
    end

    it 'maps JSON ideas to actual collection of ideas' do
      json_ideas_collection = double
      Api.stub(:ideas_for_project).and_return(json_ideas_collection)
      Ideas.should_receive(:from_json).with(project, json_ideas_collection)

      DataStore.ideas_for_project(project)
    end

    it 'maps JSON updates to acutal array of updates with properly updated stories and iterations' do
      updated_stories = double
      updated_iterations = double

      json_stories_collection = double
      json_iterations_collection = double

      Api.stub(:updates_for_project).and_return({'stories' => json_stories_collection, 'iterations' => json_iterations_collection})

      Stories.should_receive(:from_json).with(project, json_stories_collection).and_return(updated_stories)
      Iterations.should_receive(:from_json).with(project, json_iterations_collection).and_return(updated_iterations)

      updates = DataStore.updates_for_project(project)

      updates.stories.should == updated_stories
      updates.iterations.should == updated_iterations
    end

    it 'delegates fetching of project by id to the project collection' do
      projects_collection = double
      DataStore.stub(:projects).and_return(projects_collection)

      id = 12
      projects_collection.should_receive(:find_by_id).with(id)

      DataStore.find_project_by_id(id)
    end

    it 'delegates fetching of user of a project to the project' do
      id = 12
      project.should_receive(:find_user_by_id).with(id)

      DataStore.find_user_of_project_with_id(project, id)
    end
  end
end
