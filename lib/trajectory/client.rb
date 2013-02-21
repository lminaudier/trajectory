module Trajectory
  class Client
    def projects
      Api.projects.inject(Projects.new) do |memo, project|
        memo << Project.new(project.symbolize_keys!)
      end
    end
  end
end
