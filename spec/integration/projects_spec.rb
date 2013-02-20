require 'spec_helper'

require 'virtus'
require 'httparty'
require 'json'
require 'ap'

module Trajectory
  class MissingAttributeError < RuntimeError
    def initialize(object, attribute)
      @object = object
      @attribute = attribute.to_sym
    end

    def to_s
      "Attribute #{@attribute} of #{@object.inspect} is nil."
    end
  end

  class Project
    include Virtus

    attribute :id, Integer, default: lambda { |project, attribute| raise MissingAttributeError.new(project, :id) }
    attribute :name, String

    def ==(other)
      id == other.id
    end
  end

  class Client
    def projects
      response = HTTParty.get("http://www.apptrajectory.com/api/#{api_key}/accounts/#{account_keyword}/projects.json", {:headers => {'Content-Type' => 'application/json'}})
      JSON.parse(response.body).map do |project|
        Project.new(id: project['id'], name: project['name'])
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
    let(:project) { Project.new(id: 42, name: 'foo') }

    it 'can be initialized with named parameters' do
      project.name.should == 'foo'
    end

    it 'requires an id attribute' do
      expect do
        Project.new.id
      end.to raise_error(MissingAttributeError)
    end

    it 'is the same project when ids are the same' do
      project.should == Project.new(id: 42, name: 'bar')
    end
  end
end

describe 'Client' do
  it 'is able to retrieve all projects of the user' do
    VCR.use_cassette('projects') do
      projects = Trajectory::Client.new.projects

      project_1 = Trajectory::Project.new(id: 15504817, name: 'test-project')

      projects.should == [project_1]
    end
  end
end
