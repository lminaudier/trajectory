require 'spec_helper'

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
