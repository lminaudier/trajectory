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
  end
end
