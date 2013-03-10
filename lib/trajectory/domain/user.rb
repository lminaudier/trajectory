module Trajectory
  class User
    include Virtus

    # @return [Integer] the unique identifier of the User
    # @raise [MissingAttributeError] if id is nil
    attribute :id, Integer, default: lambda { |project, attribute| raise MissingAttributeError.new(project, :id) }
    # @return [String] the full name of the user
    attribute :name, String
    # @return [DateTime] the creation date of the user account
    attribute :created_at, DateTime
    # @return [DateTime] the last modification date of the user account
    attribute :updated_at, DateTime
    # @return [String] the url to the avatar image of the user (uses gravatar)
    attribute :gravatar_url, String
    # @return [String] the email of the user
    attribute :email, String

    # Returns true if two users are the sames i.e they share the same id
    # attribute
    #
    # @param other [User] the other object to compare
    # @return [true, false]
    def ==(other)
      id == other.id
    end
  end
end
