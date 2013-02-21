module Trajectory
  class DataStore
    def self.projects
      Api.projects.inject(Projects.new) do |memo, project|
        memo << Project.new(project.symbolize_keys!)
      end
    end

    def self.stories_for_project(project)
      Api.stories_for_project(project).inject(Stories.new) do |memo, story|
        memo << Story.new(story.symbolize_keys!)
      end
    end
  end
end
