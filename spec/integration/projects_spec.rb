require 'spec_helper'

require 'virtus'
require 'httparty'
require 'json'
require 'ap'

class Hash
  def symbolize_keys!
    keys.each do |key|
      self[(key.to_sym rescue key) || key] = delete(key)
    end
    self
  end
end

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
    attribute :archived, Boolean
    attribute :created_at, DateTime
    attribute :estimated_velocity, Integer
    attribute :historic_velocity, Array[Integer]
    attribute :keyword, String
    attribute :updated_at, DateTime
    attribute :completed_iterations_count, Integer
    attribute :completed_stories_count, Integer

    def ==(other)
      id == other.id
    end
  end

  class Client
    def projects
      response = HTTParty.get("http://www.apptrajectory.com/api/#{api_key}/accounts/#{account_keyword}/projects.json", {:headers => {'Content-Type' => 'application/json'}})
      projects = Projects.new
      JSON.parse(response.body).map do |project|
        projects << Project.new(project.symbolize_keys!)
      end
      projects
    end

    def api_key
      ENV['TRAJECTORY_API_KEY']
    end

    def account_keyword
      ENV['TRAJECTORY_ACCOUNT_KEYWORD']
    end
  end

  class Projects < Array
    def find_by_keyword(keyword)
      detect { |project| project.keyword == keyword } || false
    end

    def archived
      select { |project| project.archived? }
    end

    def active
      select { |project| !project.archived? }
    end
  end
end

module Trajectory
  describe Project do
    let(:project) { Project.new(id: 42, name: 'foo') }

    it 'can be initialized with named parameters' do
      project.id.should == 42
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

    context 'it has attributes accessors' do
      %w(archived? created_at estimated_velocity historic_velocity id keyword updated_at completed_iterations_count completed_stories_count).each do |attribute|
        it "'#{attribute}' accessor" do
          Project.new.should respond_to(attribute.to_sym)
        end
      end
    end
  end
end

module Trajectory
  describe Projects do
    it 'is kind of Array' do
      projects = Projects.new
      projects.should be_kind_of(Array)
    end

    it 'can find a project by keyword' do
      projects = Projects.new
      project = Fabricate(:project, keyword: 'a_keyword')
      projects << Fabricate(:project, keyword: 'some_identifier')
      projects << Fabricate(:project, keyword: 'another_identifier')
      projects << project
      projects << Fabricate(:project, keyword: 'the_last_identifier')

      projects.find_by_keyword('a_keyword').should == project
    end

    it "returns false when it can't find a project by keyword" do
      projects = Projects.new
      project = Fabricate(:project, keyword: 'a_keyword')
      projects << Fabricate(:project, keyword: 'some_identifier')
      projects << Fabricate(:project, keyword: 'another_identifier')
      projects << Fabricate(:project, keyword: 'the_last_identifier')

      projects.find_by_keyword('a_keyword').should == false
    end

    it 'can filter active projects' do
      projects = Projects.new

      project_1 = Fabricate(:project, archived: true)
      project_2 = Fabricate(:project, archived: true)
      project_3 = Fabricate(:project, archived: true)

      projects << Fabricate(:project, archived: false)
      projects << project_1
      projects << Fabricate(:project, archived: false)
      projects << project_2
      projects << project_3
      projects << Fabricate(:project, archived: false)

      projects.archived.should include(project_1)
      projects.archived.should include(project_2)
      projects.archived.should include(project_3)
    end

    it 'can filter archived projects' do
      projects = Projects.new

      project_1 = Fabricate(:project, archived: false)
      project_2 = Fabricate(:project, archived: false)
      project_3 = Fabricate(:project, archived: false)

      projects << Fabricate(:project, archived: true)
      projects << project_1
      projects << Fabricate(:project, archived: true)
      projects << project_2
      projects << project_3
      projects << Fabricate(:project, archived: true)

      projects.active.should include(project_1)
      projects.active.should include(project_2)
      projects.active.should include(project_3)
    end
  end
end

describe Trajectory::Client do
  it 'is able to retrieve all projects of the user' do
    VCR.use_cassette('projects') do
      projects = Trajectory::Client.new.projects

      project_1 = Trajectory::Project.new(id: 15504817)

      projects.should be_kind_of(Trajectory::Projects)
      projects.should == (Trajectory::Projects.new << project_1)
    end
  end
end
