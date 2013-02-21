module Trajectory
  class Client
    def initialize
      check_environment!
    end

    def check_environment!
      raise "Specify trajectory API environment variables : TRAJECTORY_API_KEY and TRAJECTORY_ACCOUNT_KEYWORD" if ENV['TRAJECTORY_API_KEY'].nil? || ENV['TRAJECTORY_ACCOUNT_KEYWORD'].nil?
    end

    def projects
      DataStore.projects
    end
  end
end
