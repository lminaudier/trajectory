module Trajectory
  class Users < SimpleDelegator
    alias :users :__getobj__

    # Creates a new collection of {User}
    #
    # @param users [Array<User>] a arbitrary lenght list of {User} objects
    def initialize(*users)
      super(users)
    end

    # Create a new collection of {User} from a JSON array of attributes from trajectory API
    #
    # @param json_attributes [Hash] the hash of attributes of each user of the collection
    def self.from_json(json_attributes)
      new(*json_attributes.map do |attributes|
        User.new(attributes.symbolize_keys!)
      end)
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
