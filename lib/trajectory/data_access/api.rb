require 'httparty'

module Trajectory
  class Api
    include HTTParty
    base_uri "https://www.apptrajectory.com/api/#{ENV['TRAJECTORY_API_KEY']}/accounts/#{ENV['TRAJECTORY_ACCOUNT_KEYWORD']}"

    class << self
      def projects
        JSON.parse get_json("/projects.json")
      end

      def users_for_project(project)
        JSON.parse get_json("/projects/#{project.keyword}/users.json")
      end

      def stories_for_project(project)
        JSON.parse(get_json("/projects/#{project.keyword}/stories/completed.json"))['stories'] +
        JSON.parse(get_json("/projects/#{project.keyword}/stories.json"))['stories']
      end

      def iterations_for_project(project)
        JSON.parse(get_json("/projects/#{project.keyword}/iterations.json"))
      end

      def ideas_for_project(project)
        JSON.parse(get_json("/projects/#{project.keyword}/ideas.json"))
      end

      def get_json(url)
        get_body(url, options)
      end

      def options
        {:headers => {'Content-Type' => 'application/json'}}
      end

      def get_body(*args)
        get(*args).body
      end
    end
  end
end
