require 'spec_helper'
require 'ostruct'

module Trajectory
  describe Api do
    describe '#projects' do
      it 'make an API call to retrieve all trajectory projects' do
        query = '/projects.json'
        body = [{'id' => '1234'}]
        headers = {:headers => {'Content-Type' => 'application/json'}}

        Api.should_receive(:get).
          with(query, headers).
          and_return(OpenStruct.new :headers => headers, :body => body.to_json)

        Api.projects.should == body
      end
    end

    let(:project) { double(:project, :keyword => 'project-keyword') }

    describe '#users_for_project' do
      it 'make an API call to retrieve all users of a given project' do

        query = "/projects/#{project.keyword}/users.json"
        body = [{'id' => '1234'}]
        headers = {:headers => {'Content-Type' => 'application/json'}}

        Api.should_receive(:get).
          with(query, headers).
          and_return(OpenStruct.new :headers => headers, :body => body.to_json)

        Api.users_for_project(project).should == body
      end
    end

    describe '#stories_for_project' do
      it 'make an API call to retrieve all users of a given project' do
        not_completed_stories_query = "/projects/#{project.keyword}/stories.json"
        completed_stories_query = "/projects/#{project.keyword}/stories/completed.json"
        not_completed_stories_body = {'stories' => [{'id' => '1234'}]}
        completed_stories_body = {'stories' => [{'id' => '1234'}]}
        headers = {:headers => {'Content-Type' => 'application/json'}}

        Api.should_receive(:get).
          with(not_completed_stories_query, headers).
          and_return(OpenStruct.new :headers => headers, :body => not_completed_stories_body.to_json)
        Api.should_receive(:get).
          with(completed_stories_query, headers).
          and_return(OpenStruct.new :headers => headers, :body => completed_stories_body.to_json)

        Api.stories_for_project(project).should == completed_stories_body['stories'] + not_completed_stories_body['stories']
      end
    end

    describe '#iterations_for_project' do
      it 'make an API call to retrieve all users of a given project' do
        query = "/projects/#{project.keyword}/iterations.json"
        body = [{'id' => '1234'}]
        headers = {:headers => {'Content-Type' => 'application/json'}}

        Api.should_receive(:get).
          with(query, headers).
          and_return(OpenStruct.new :headers => headers, :body => body.to_json)

        Api.iterations_for_project(project).should == body
      end
    end

    describe '#ideas_for_project' do
      it 'make an API call to retrieve all users of a given project' do
        query = "/projects/#{project.keyword}/ideas.json"
        body = [{'id' => '1234'}]
        headers = {:headers => {'Content-Type' => 'application/json'}}

        Api.should_receive(:get).
          with(query, headers).
          and_return(OpenStruct.new :headers => headers, :body => body.to_json)

        Api.ideas_for_project(project).should == body
      end
    end

    describe '#updates_for_project' do
      it 'make an API call to retrieve all users of a given project' do
        since = DateTime.now

        query = "/projects/#{project.keyword}/updates.json?since=#{since}"
        body = [{'id' => '1234'}]
        headers = {:headers => {'Content-Type' => 'application/json'}}

        Api.should_receive(:get).
          with(query, headers).
          and_return(OpenStruct.new :headers => headers, :body => body.to_json)

        Api.updates_for_project(project, since).should == body
      end
    end
  end
end
