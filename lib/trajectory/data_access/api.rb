require 'httparty'

module Trajectory
  class Api
    include HTTParty
    base_uri "https://www.apptrajectory.com/api/#{ENV['TRAJECTORY_API_KEY']}/accounts/#{ENV['TRAJECTORY_ACCOUNT_KEYWORD']}"

    class << self
      def projects
        get_json("/projects.json")
      end

      def users_for_project(project)
        get_json("/projects/#{project.keyword}/users.json")
      end

      def stories_for_project(project)
        get_json("/projects/#{project.keyword}/stories/completed.json")['stories'] +
        get_json("/projects/#{project.keyword}/stories.json")['stories']
      end

      def iterations_for_project(project)
        get_json("/projects/#{project.keyword}/iterations.json")
      end

      def ideas_for_project(project)
        get_json("/projects/#{project.keyword}/ideas.json")
      end

      def updates_for_project(project, since)
        get_json("/projects/#{project.keyword}/updates.json?since=#{since.to_s}")
      end

      private
      def get_json(url)
        JSON.parse(get_body(url, options))
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
