require "spec_helper"

module Trajectory
  describe Ideas do
    it 'can be initialized from json array of components attributes' do
      project = double(:project, :id => 4567)
      json_ideas_collection = [{'id' => 1234, 'subject' => 'idea-subject'}, {'id' => 42, 'subject' => 'other-idea-subject'}]

      ideas = Ideas.from_json(project, json_ideas_collection)

      ideas.should be_kind_of(Ideas)
      ideas.first.id.should == 1234
      ideas.first.subject.should == 'idea-subject'

      ideas[1].id.should == 42
      ideas[1].subject.should == 'other-idea-subject'

      ideas.first.project_id.should == 4567
      ideas[1].project_id.should == 4567
    end
  end
end
