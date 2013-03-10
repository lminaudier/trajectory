module Trajectory
  class Users < SimpleDelegator
    alias :users :__getobj__

    # Creates a new collection of {User}
    #
    # @param users [Array<User>] a arbitrary lenght list of {User} objects
    def initialize(*users)
      super(users)
    end

    # Returns the the first user with the given id in the collection or false if
    # no user can be found with the id
    #
    # @param id [Integer] the id of the user to find
    # @return [User, false] the user with the given id
    def find_by_id(id)
      users.find { |user| user.id == id } || false
    end
  end
end
