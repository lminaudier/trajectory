require 'spec_helper'

describe Trajectory::Client do
  it 'is able to retrieve all projects of the user' do
    VCR.use_cassette('projects') do
      projects = Trajectory::Client.new.projects

      project_1 = Trajectory::Project.new(id: 15504817)

      projects.should == Trajectory::Projects.new(project_1)
    end
  end
end
