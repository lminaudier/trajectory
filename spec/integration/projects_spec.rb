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

module Trajectory
  describe Project do
    let(:project) { Project.new(name: 'foo') }

    it 'can be initialized with named parameters' do
      project.name.should == 'foo'
    end

    it 'is the same project when names are the same' do
      project.should == Project.new(name: 'foo')
    end
  end
end

describe 'Client' do
  it 'is able to retrieve all projects of the user' do
    projects = Trajectory::Client.new.projects

    project_1 = Trajectory::Project.new(name: 'test-project-1')
    project_2 = Trajectory::Project.new(name: 'test-project-2')

    projects.should == [project_1, project_2]
  end
end
