module Trajectory
  module DataStore
    extend self

    def projects
      @projects ||= Projects.from_json(Api.projects)
    end

    def users_for_project(project)
      Users.from_json Api.users_for_project(project)
    end

    def stories_for_project(project)
      Stories.from_json project, Api.stories_for_project(project)
    end

    def ideas_for_project(project)
      Ideas.from_json project, Api.ideas_for_project(project)
    end

    def updates_for_project(project, since = DateTime.now)
      updates = Api.updates_for_project(project, since).symbolize_keys!

      stories = Stories.from_json(project, updates[:stories])
      iterations = Iterations.from_json(project, updates[:iterations])

      Update.new(stories, iterations)
    end

    def find_project_by_id(id)
      projects.find_by_id(id)
    end

    def find_user_of_project_with_id(project, user_id)
      project.find_user_by_id(user_id)
    end

    def iterations_for_project(project)
      Iterations.from_json project, Api.iterations_for_project(project)
    end
  end
end
