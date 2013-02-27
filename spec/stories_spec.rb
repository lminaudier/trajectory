require 'spec_helper'

module Trajectory
  describe Stories do
    it 'can filter started stories' do
      story_1 = Fabricate(:story, state: :started)
      story_2 = Fabricate(:story, state: :started)
      story_3 = Fabricate(:story, state: :started)
      stories = Stories.new(Fabricate(:story, state: :unstarted),
                            story_1,
                            Fabricate(:story, state: :delivered),
                            Fabricate(:story, state: :accepted),
                            story_2,
                            story_3,
                            Fabricate(:story, state: :rejected))

      stories.started.should == Stories.new(story_1, story_2, story_3)
    end

    it 'can filter unstarted stories' do
      story_1 = Fabricate(:story, state: :unstarted)
      story_2 = Fabricate(:story, state: :unstarted)
      story_3 = Fabricate(:story, state: :unstarted)
      stories = Stories.new(Fabricate(:story, state: :started),
                            story_1,
                            Fabricate(:story, state: :delivered),
                            Fabricate(:story, state: :accepted),
                            story_2,
                            story_3,
                            Fabricate(:story, state: :rejected))

      stories.unstarted.should == Stories.new(story_1, story_2, story_3)
    end

    it 'can filter not completed stories' do
      story_1 = Fabricate(:story, state: :unstarted)
      story_2 = Fabricate(:story, state: :started)
      story_3 = Fabricate(:story, state: :delivered)
      stories = Stories.new(Fabricate(:story, state: :accepted),
                            story_1,
                            Fabricate(:story, state: :accepted),
                            Fabricate(:story, state: :accepted),
                            story_2,
                            story_3,
                            Fabricate(:story, state: :accepted))

      stories.not_completed.should == Stories.new(story_1, story_2, story_3)
    end

    it 'can filter stories of a given iteration' do
      story_1 = Fabricate(:story, iteration_id: 12)
      story_2 = Fabricate(:story, iteration_id: 12)
      story_3 = Fabricate(:story, iteration_id: 12)
      stories = Stories.new(Fabricate(:story),
                            story_1,
                            Fabricate(:story),
                            Fabricate(:story),
                            story_2,
                            story_3,
                            Fabricate(:story))

      iteration = double(:id => 12)
      stories.in_iteration(iteration).should == Stories.new(story_1, story_2, story_3)
    end
  end
end
