require 'spec_helper'

module Trajectory
  describe Stories do
    it 'can be initialized from json attributes of its components' do
      project = double(:project, :id => 4567)
      json_stories_collection = [{'id' => 1234, 'title' => 'foo'}, {'id' => 42, 'title' => 'bar'}]

      stories = Stories.from_json(project, json_stories_collection)

      stories.should be_kind_of(Stories)
      stories.first.id.should == 1234
      stories.first.title.should == 'foo'

      stories[1].id.should == 42
      stories[1].title.should == 'bar'

      stories.first.project_id.should == 4567
      stories[1].project_id.should == 4567
    end

    it 'can filter started stories' do
      story_1 = double(:started? => true)
      story_2 = double(:started? => true)
      story_3 = double(:started? => true)
      stories = Stories.new(double(:started? => false),
                            story_1,
                            double(:started? => false),
                            double(:started? => false),
                            story_2,
                            story_3,
                            double(:started? => false))

      stories.started.should == Stories.new(story_1, story_2, story_3)
    end

    it 'can filter unstarted stories' do
      story_1 = double(:unstarted? => true)
      story_2 = double(:unstarted? => true)
      story_3 = double(:unstarted? => true)
      stories = Stories.new(double(:unstarted? => false),
                            story_1,
                            double(:unstarted? => false),
                            double(:unstarted? => false),
                            story_2,
                            story_3,
                            double(:unstarted? => false))

      stories.unstarted.should == Stories.new(story_1, story_2, story_3)
    end

    it 'can filter not completed stories' do
      story_1 = double(:completed? => false)
      story_2 = double(:completed? => false)
      story_3 = double(:completed? => false)
      stories = Stories.new(double(:completed? => true),
                            story_1,
                            double(:completed? => true),
                            double(:completed? => true),
                            story_2,
                            story_3,
                            double(:completed? => true))

      stories.not_completed.should == Stories.new(story_1, story_2, story_3)
    end

    it 'can filter stories of a given iteration' do
      iteration = double(:id => 12)

      story_1 = double(:in_iteration? => true)
      story_2 = double(:in_iteration? => true)
      story_3 = double(:in_iteration? => true)
      stories = Stories.new(double(:in_iteration? => false),
                            story_1,
                            double(:in_iteration? => false),
                            double(:in_iteration? => false),
                            story_2,
                            story_3,
                            double(:in_iteration? => false))

      stories.in_iteration(iteration).should == Stories.new(story_1, story_2, story_3)
    end
  end
end
