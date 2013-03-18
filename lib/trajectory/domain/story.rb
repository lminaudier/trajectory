module Trajectory
  class Story
    include Virtus

    # @return [Integer] the unique identifier of the story
    # @raise [MissingAttributeError] if id is nil
    attribute :id, Integer, default: lambda { |project, attribute| raise MissingAttributeError.new(project, :id) }
    # @return [String] the name of the user assigned to the story
    attribute :assignee_name, String
    # @return [String] the type of story as "Feature", "Bug", "Todo" or "Milestone"
    attribute :task_type, String
    # The Integer position of the story in the backlog.
    # Lower is higher.
    # @return [Integer] the position of the story
    attribute :position, Integer
    # @return [DateTime] the creation date of the story
    attribute :created_at, DateTime
    # @return [Array<Symbol>] the valid states the story can transition to
    attribute :state_events, Array[Symbol]
    # @return [String] the title of the story
    attribute :title, String
    # @return [true, false] true if design is needed for the story, false otherwise
    attribute :design_needed, Boolean
    # @return [DateTime] the last modification date of the story
    attribute :updated_at, DateTime
    # @return [String] the subject of the idea the story is attached to
    attribute :idea_subject, String
    # @!method archived?
    # @return [true, false] true if the story has been archived, false otherwise
    attribute :archived, Boolean
    # @return [Integer] estimation in points of the story complexity
    attribute :points, Integer
    # @!method development_needed?
    # @return [true, false] true if development is needed for the story, false otherwise
    attribute :development_needed, Boolean
    # @!method deleted?
    # @return [ture, false] true if the story has been deleted, false otherwise
    attribute :deleted, Boolean
    # @return [String] name of the user that created the story
    attribute :user_name, String
    # @return [Integer] id of the user that created the story
    # @see #user
    attribute :user_id, Integer
    # @return [Integer] number of comments of the story
    attribute :comments_count, Integer
    # @return [Symbol] state of the story in [:started, :unstarted, :delivered, :accepted, :rejected]
    attribute :state, Symbol
    # @return [Integer] project id the story belongs to
    # @see #project
    attribute :project_id, Integer
    # @return [Integer] iteration id the story belongs to
    # @see #iteration
    attribute :iteration_id, Integer

    # Returns true if two stories are the sames i.e they share the same id
    # attribute
    #
    # @param other [Story] the other object to compare
    # @return [true, false]
    def ==(other)
      id == other.id
    end

    # Fetch the project the story belongs to
    #
    # @return [Project]
    def project
      @project ||= DataStore.find_project_by_id(project_id)
    end

    # Returns true if the story is started i.e in :started state
    #
    # @return [true, false]
    def started?
      state == :started
    end

    # Returns true if the story is not started i.e in :unstarted state
    #
    # @return [true, false]
    def unstarted?
      state == :unstarted
    end

    # Returns true if the story is not completed i.e not in :accepted state
    #
    # @return [true, false]
    def not_completed?
      !completed?
    end

    # Returns true if the story is completed i.e in :accepted state
    #
    # @return [true, false]
    def completed?
      state == :accepted
    end

    # Fetch the user that created the story
    #
    # @return [User]
    def user
      @user ||= DataStore.find_user_of_project_with_id(project, user_id)
    end

    # Returns true if the story belongs to the given iteration, false otherwise
    #
    # @param iteration [Iteration] an iteration
    # @return [true, false]
    def in_iteration?(iteration)
      iteration_id == iteration.id
    end

    # Returns the iteration the story belongs to or false if iteration can't be
    # found
    #
    # @return [Iteration, false] the iteration or false
    def iteration
      @iteration ||= DataStore.find_iteration_of_project_by_id(project, iteration_id)
    end
  end
end
