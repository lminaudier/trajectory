module Trajectory
  module DataStore
    extend self

    # @return [Projects] the collection of projects of the trajectory account
    def projects
      @projects ||= Projects.from_json(Api.projects)
    end

    # @return [Users] the collection of users of the trajectory account
    def users_for_project(project)
      Users.from_json Api.users_for_project(project)
    end

    # Fetches all stories of a given project
    #
    # @param project [Project] the project
    # @return [Stories] the collection of stories
    def stories_for_project(project)
      Stories.from_json project, Api.stories_for_project(project)
    end

    # Fetches all ideas of a given project
    #
    # @param project [Project] the project
    # @return [Ideas] the collection of ideas
    def ideas_for_project(project)
      Ideas.from_json project, Api.ideas_for_project(project)
    end

    # Fetches all updates of a given project since a given date
    #
    # @param project [Project] the project
    # @param since [DateTime] a datetime
    # @return [Ideas] the collection of updates
    def updates_for_project(project, since = DateTime.now)
      updates = Api.updates_for_project(project, since).symbolize_keys!

      stories = Stories.from_json(project, updates[:stories])
      iterations = Iterations.from_json(project, updates[:iterations])

      Update.new(stories, iterations)
    end

    # Fetches a project by id in the collection of accessible projects
    #
    # @param id [Integer] the project id
    # @return [Project, false] the found project or false
    def find_project_by_id(id)
      projects.find_by_id(id)
    end

    # Fetches a user of a given project by id
    #
    # @param project [Project] the project
    # @param user_id [Integer] the user id
    # @return [User, false] the found user or false
    def find_user_of_project_with_id(project, user_id)
      project.find_user_by_id(user_id)
    end

    # Fetches all iterations of a given project
    #
    # @param project [Project] the project
    # @return [Iterations] the collection of iterations
    def iterations_for_project(project)
      Iterations.from_json project, Api.iterations_for_project(project)
    end
  end
end
