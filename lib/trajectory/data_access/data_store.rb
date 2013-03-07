module Trajectory
  module DataStore
    extend self

    def projects
      @projects ||= Projects.new(*Api.projects.map do |project|
        Project.new(project.symbolize_keys!)
      end)
    end

    def users_for_project(project)
      Users.new(*Api.users_for_project(project).map do |user|
        User.new(user.symbolize_keys!)
      end)
    end

    def stories_for_project(project)
      Stories.new(*Api.stories_for_project(project).map do |story|
        attributes = story.symbolize_keys!.merge({project_id: project.id})
        Story.new(attributes)
      end)
    end

    def ideas_for_project(project)
      Ideas.new(*Api.ideas_for_project(project).map do |idea|
        attributes = idea.symbolize_keys!.merge({project_id: project.id})
        Idea.new(attributes)
      end)
    end

    def find_project_by_id(id)
      projects.find_by_id(id)
    end

    def find_user_of_project_with_id(project, user_id)
      project.find_user_by_id(user_id)
    end

    def iterations_for_project(project)
      Iterations.new(*Api.iterations_for_project(project).map do |attributes|
        attributes = attributes.symbolize_keys!.merge({project_id: project.id})
        attributes[:current] = attributes[:current?]
        attributes.delete(:current?)
        Iteration.new(attributes)
      end)
    end
  end
end
