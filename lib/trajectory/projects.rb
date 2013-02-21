require 'delegate'

module Trajectory
  class Projects < SimpleDelegator
    alias :projects :__getobj__

    def initialize(*projects)
      super(projects)
    end

    def find_by_id(id)
      projects.find { |project| project.id == id } || false
    end

    def find_by_keyword(keyword)
      projects.find { |project| project.keyword == keyword } || false
    end

    def archived
      projects.select { |project| project.archived? }
    end

    def active
      projects.select { |project| !project.archived? }
    end
  end
end
