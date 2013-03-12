module Trajectory
  class Client
    def initialize
      check_environment!
    end

    def check_environment!
      raise BadEvnrionmentError if ENV['TRAJECTORY_API_KEY'].nil? || ENV['TRAJECTORY_ACCOUNT_KEYWORD'].nil?
    end

    def projects
      DataStore.projects
    end
  end
end
