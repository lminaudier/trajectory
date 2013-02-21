require 'spec_helper'

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
