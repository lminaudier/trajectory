require 'spec_helper'

module Trajectory
  describe Users do
    it 'can find a project by id' do
      user = double(:user, id: 1234)
      users = Users.new(double(:project, id: 1),
                 double(:user, id: 2),
                 user,
                 double(:user, id: 3))

      users.find_by_id(1234).should == user
    end

    it "returns false when it can't find a user by id" do
      users = Users.new(double(:user, id: 1),
                              double(:user, id: 2),
                              double(:user, id: 3))

      users.find_by_id(1234).should == false
    end
  end
end
