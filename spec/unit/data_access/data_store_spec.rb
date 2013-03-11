require 'spec_helper'

module Trajectory
  describe DataStore do
    it 'maps JSON projects to actual collection of projects' do
      json_projects_collection = [{'id' => 1234, 'name' => 'foo'}, {'id' => 42, 'name' => 'bar'}]

      Api.stub(:projects).and_return(json_projects_collection)

      projects = DataStore.projects

      projects.should be_kind_of(Projects)
      projects.first.id.should == 1234
      projects.first.name.should == 'foo'

      projects[1].id.should == 42
      projects[1].name.should == 'bar'
    end

    let(:project) { double(:project, :id => 4567) }

    it 'maps JSON users to actual collection of users' do
      json_users_collection = [{'id' => 1234, 'email' => 'foo@exemple.com'}, {'id' => 42, 'email' => 'bar@exemple.com'}]

      Api.stub(:users_for_project).and_return(json_users_collection)

      users = DataStore.users_for_project(project)

      users.should be_kind_of(Users)
      users.first.id.should == 1234
      users.first.email.should == 'foo@exemple.com'

      users[1].id.should == 42
      users[1].email.should == 'bar@exemple.com'
    end

    it 'maps JSON stories to actual collection of stories' do
      json_stories_collection = [{'id' => 1234, 'title' => 'foo'}, {'id' => 42, 'title' => 'bar'}]

      Api.stub(:stories_for_project).and_return(json_stories_collection)

      stories = DataStore.stories_for_project(project)

      stories.should be_kind_of(Stories)
      stories.first.id.should == 1234
      stories.first.title.should == 'foo'

      stories[1].id.should == 42
      stories[1].title.should == 'bar'
    end

    it 'associates stories and their project with the project id' do
      json_stories_collection = [{'id' => 1234, 'title' => 'foo'}, {'id' => 42, 'title' => 'bar'}]

      Api.stub(:stories_for_project).and_return(json_stories_collection)

      stories = DataStore.stories_for_project(project)

      stories.first.project_id.should == 4567
      stories[1].project_id.should == 4567
    end

    it 'maps JSON iterations to actual collection of iterations' do
      json_iterations_collection = [{'id' => 1234, 'estimated_points' => 12}, {'id' => 42, 'estimated_points' => 10}]

      Api.stub(:iterations_for_project).and_return(json_iterations_collection)

      iterations = DataStore.iterations_for_project(project)

      iterations.should be_kind_of(Iterations)
      iterations.first.id.should == 1234
      iterations.first.estimated_points.should == 12

      iterations[1].id.should == 42
      iterations[1].estimated_points.should == 10
    end

    it 'associates iterations and their project with the project id' do
      json_iterations_collection = [{'id' => 1234, 'title' => 'foo'}, {'id' => 42, 'title' => 'bar'}]

      Api.stub(:iterations_for_project).and_return(json_iterations_collection)

      iterations = DataStore.iterations_for_project(project)

      iterations.first.project_id.should == 4567
      iterations[1].project_id.should == 4567
    end

    it 'maps JSON ideas to actual collection of ideas' do
      json_ideas_collection = [{'id' => 1234, 'subject' => 'idea-subject'}, {'id' => 42, 'subject' => 'other-idea-subject'}]

      Api.stub(:ideas_for_project).and_return(json_ideas_collection)

      ideas = DataStore.ideas_for_project(project)

      ideas.should be_kind_of(Ideas)
      ideas.first.id.should == 1234
      ideas.first.subject.should == 'idea-subject'

      ideas[1].id.should == 42
      ideas[1].subject.should == 'other-idea-subject'
    end

    it 'associates ideas and their project with the project id' do
      json_ideas_collection = [{'id' => 1234, 'subject' => 'idea-subject'}, {'id' => 42, 'subject' => 'other-idea-subject'}]

      Api.stub(:ideas_for_project).and_return(json_ideas_collection)

      ideas = DataStore.ideas_for_project(project)

      ideas.first.project_id.should == 4567
      ideas[1].project_id.should == 4567
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
