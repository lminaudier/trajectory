require 'spec_helper'

require 'virtus'
require 'httparty'
require 'json'
require 'ap'

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
      response = HTTParty.get("http://www.apptrajectory.com/api/#{api_key}/accounts/#{account_keyword}/projects.json", {:headers => {'Content-Type' => 'application/json'}})
      JSON.parse(response.body).map do |project|
        Project.new(name: project["name"])
      end
    end

    def api_key
      ENV['TRAJECTORY_API_KEY']
    end

    def account_keyword
      ENV['TRAJECTORY_ACCOUNT_KEYWORD']
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

    project_1 = Trajectory::Project.new(name: 'test-project')

    projects.should == [project_1]
  end
end
