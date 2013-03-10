module Trajectory
  class Idea
    include Virtus

    # @return [Integer] the unique identifier of the idea.
    # @raise [MissingAttributeError] if id is nil
    attribute :id, Integer, default: lambda { |project, attribute| raise MissingAttributeError.new(project, :id) }
    # @return [String] the subject (i.e title) of the idea
    attribute :subject, String
    # @return [Integer] the number of stories associated with the idea
    attribute :stories_count, Integer
    # @return [Integer] the number of comments on the idea
    attribute :comments_count, Integer
    # @return [String] Name of the last user that have commented on the idea
    attribute :last_comment_user_name, String
    # @return [DateTime] date of the last comment on the idea
    attribute :last_comment_created_at, DateTime
    # @return [DateTime] date of the last activity (i.e edit, comment, ...) on the idea
    attribute :last_activity_at, DateTime
    # @!method editable_by_current_user?
    # @return [true, false] true if the user can edit the idea, false otherwise
    attribute :editable_by_current_user, Boolean
    # @return [Integer] idea of the user that created the idea
    # @see #user
    attribute :user_id, Integer
    # @return [Array<Integer>] the ids of the users that have subscribed to the
    # @see #subscribed_users
    attribute :subscribed_user_ids, Array[Integer]
    # @return [Integer] the id of the project the idea belongs to
    # @see #project
    attribute :project_id, Integer
    # @return [String] the content of the idea
    attribute :body, String

    # Returns true if two ideas are the sames i.e they share the same id
    # attribute
    #
    # @param other [Idea] the other object to compare
    # @return [true, false]
    def ==(other)
      id == other.id
    end

    # Fetch the project the idea belongs to
    #
    # @return [Project]
    def project
      DataStore.find_project_by_id(project_id)
    end

    # Fetch the user that created the idea
    #
    # @return [User]
    def user
      DataStore.find_user_of_project_with_id(project, user_id)
    end

    # @todo Not Yet Implemented
    def subscribed_users
    end

    # @todo Not Yet Implemented
    def percent_complete
    end

    # @todo Not Yet Implemented
    def stories
    end
  end
end
