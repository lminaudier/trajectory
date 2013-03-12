module Trajectory
  class Client
    # Creates a new trajectory client
    #
    # @return [Client]
    def initialize
      check_environment!
    end

    # Checks if environment variables are set.
    #
    # @raise [BadEvnrionmentError] if TRAJECTORY_API_KEY and TRAJECTORY_ACCOUNT_KEYWORD are not set
    def check_environment!
      raise BadEvnrionmentError if ENV['TRAJECTORY_API_KEY'].nil? || ENV['TRAJECTORY_ACCOUNT_KEYWORD'].nil?
    end

    # Fetches all trajectory projects of the account
    #
    # @return [Projects] the projects collection
    def projects
      DataStore.projects
    end
  end
end
