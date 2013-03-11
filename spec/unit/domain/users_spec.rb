require 'spec_helper'

module Trajectory
  describe Users do
    it 'can be initialize from an array of JSON attributes of its components' do
      json_users_collection = [{'id' => 1234, 'email' => 'foo@exemple.com'}, {'id' => 42, 'email' => 'bar@exemple.com'}]

      users = Users.from_json(json_users_collection)

      users.should be_kind_of(Users)
      users.first.id.should == 1234
      users.first.email.should == 'foo@exemple.com'

      users[1].id.should == 42
      users[1].email.should == 'bar@exemple.com'
    end

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
