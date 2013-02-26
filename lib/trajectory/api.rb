require 'httparty'

module Trajectory
  class Api
    include HTTParty
    base_uri "https://www.apptrajectory.com/api/#{ENV['TRAJECTORY_API_KEY']}/accounts/#{ENV['TRAJECTORY_ACCOUNT_KEYWORD']}"

    def self.projects
      new.projects
    end

    def projects
      JSON.parse get_json("/projects.json")
    end

    def self.stories_for_project(project)
      new.stories_for_project(project)
    end

    def stories_for_project(project)
      JSON.parse(get_json("/projects/#{project.keyword}/stories/completed.json"))['stories'] +
      JSON.parse(get_json("/projects/#{project.keyword}/stories.json"))['stories']
    end

    def self.iterations_for_project(project)
      new.iterations_for_project(project)
    end

    def iterations_for_project(project)
      JSON.parse(get_json("/projects/#{project.keyword}/iterations.json"))
    end

    private
    def get_json(url)
      get_body(url, options)
    end

    def options
      {:headers => {'Content-Type' => 'application/json'}}
    end

    def get_body(*args)
      self.class.get(*args).body
    end
  end
end
