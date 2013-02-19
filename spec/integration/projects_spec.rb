require 'spec_helper'

require 'virtus'

module Trajectory
  class Project
    include Virtus

    attribute :name, String

    def ==(other)
      name == other.name
    end
  end

  class Client
    def projects
      [Project.new(name: 'test-project-1'), Project.new(name: 'test-project-2')]
    end
  end
end

describe 'Wrapper' do
  it 'is able to retrieve all projects of the user' do
    projects = Trajectory::Client.new.projects

    project_1 = Trajectory::Project.new(name: 'test-project-1')
    project_2 = Trajectory::Project.new(name: 'test-project-2')

    projects.should == [project_1, project_2]
  end
end
