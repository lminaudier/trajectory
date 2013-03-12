require 'spec_helper'

module Trajectory
  describe BadEvnrionmentError do
    it 'tell to the user to set environment variables' do
      BadEvnrionmentError.new.to_s.should == "Specify trajectory API environment variables : TRAJECTORY_API_KEY and TRAJECTORY_ACCOUNT_KEYWORD"
    end
  end
end
