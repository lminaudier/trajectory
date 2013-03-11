require 'spec_helper'

module Trajectory
  describe Projects do
    it 'can be initialized from an array of json attributes of its components' do
      json_projects_collection = [{'id' => 1234, 'name' => 'foo'}, {'id' => 42, 'name' => 'bar'}]

      projects = Projects.from_json(json_projects_collection)

      projects.should be_kind_of(Projects)
      projects.first.id.should == 1234
      projects.first.name.should == 'foo'

      projects[1].id.should == 42
      projects[1].name.should == 'bar'
    end

    it 'can find a project by id' do
      project = double(:project, id: 1234)
      projects = Projects.new(double(:project, id: 1),
                 double(:project, id: 2),
                 project,
                 double(:project, id: 3))

      projects.find_by_id(1234).should == project
    end

    it "returns false when it can't find a project by id" do
      projects = Projects.new(double(:project, id: 1),
                              double(:project, id: 2),
                              double(:project, id: 3))

      projects.find_by_id(1234).should == false
    end

    it 'can find a project by keyword' do
      project = double(:project, keyword: 'a_keyword')
      projects = Projects.new(double(:project, keyword: 'some_identifier'),
                              double(:project, keyword: 'another_identifier'),
                              project,
                              double(:project, keyword: 'the_last_identifier'))

      projects.find_by_keyword('a_keyword').should == project
    end

    it "returns false when it can't find a project by keyword" do
      projects = Projects.new(double(:project, keyword: 'some_identifier'),
                              double(:project, keyword: 'another_identifier'),
                              double(:project, keyword: 'the_last_identifier'))

      projects.find_by_keyword('a_keyword').should == false
    end

    it 'can filter active projects' do
      project_1 = double(:archived? => true)
      project_2 = double(:archived? => true)
      project_3 = double(:archived? => true)

      projects = Projects.new(double(:archived? => false),
                              project_1,
                              double(:archived? => false),
                              project_2,
                              project_3,
                              double(:archived? => false))

      projects.archived.should include(project_1, project_2, project_3)
    end

    it 'can filter archived projects' do
      project_1 = double(:archived? => false)
      project_2 = double(:archived? => false)
      project_3 = double(:archived? => false)

      projects = Projects.new(double(:archived? => true),
                              project_1,
                              double(:archived? => true),
                              project_2,
                              project_3,
                              double(:archived? => true))

      projects.active.should include(project_1, project_2, project_3)
    end
  end
end
