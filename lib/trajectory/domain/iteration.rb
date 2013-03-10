module Trajectory
  class Iteration
    include Virtus

    attr_writer :project

    # @return [Integer] the unique identifier of the iteration.
    # @raise [MissingAttributeError] if id is nil
    attribute :id, Integer, default: lambda { |project, attribute| raise MissingAttributeError.new(project, :id) }
    # @return [Float] the completion percentage of the iteration
    attribute :percent_complete, Float
    # @return [Integer] number of started stories in the iteration
    attribute :started_stories_count, Integer
    # @return [DateTime] creation date of the iteration
    attribute :created_at, DateTime
    # @return [Integer] estimated velocity of the project
    attribute :estimated_velocity, Integer
    # @return [Integer] number of delivered stories in the iteration
    attribute :delivered_stories_count, Integer
    # @return [DateTime] last modification date of the iteration
    attribute :updated_at, DateTime
    # @return [Integer] number of unstarted stories
    attribute :unstarted_stories_count, Integer
    # @return [DateTime] start date of the iteration
    attribute :starts_on, DateTime
    # @!method current?
    # @return [true, false] true if iteration is the current iteration, false otherwise
    attribute :current, Boolean
    # @return [Integer] number of stories in the iteration
    attribute :stories_count, Integer
    # @!method complete?
    # @return [true, false] return true if the iteration has been completed, false otherwise
    attribute :complete, Boolean
    # Sum of points accepted stories in the iteration
    #
    # @return [Integer] number of accepted points
    attribute :accepted_points, Integer
    # Sum of all points of all stories of the iteration
    #
    # @return [Integer] number of estimated points
    attribute :estimated_points, Integer
    # @return [Integer] number of comments of the story
    attribute :comments_count, Integer
    # @return [Integer] bumber of accepted stories
    attribute :accepted_stories_count, Integer
    # @return [Integer] d of the project the iteration belongs to
    # @see #project
    attribute :project_id, Integer

    # @!method past?
    #
    # Returns true if iteration is a past one i.e has been completed
    #
    # @return [true, false]
    alias :past? :complete?

    # Returns true if the iteration is a future one i.e not started and not completed
    def future?
      !current? && !complete?
    end

    # Returns true if two iterations are the sames i.e they share the same id
    # attribute
    #
    # @param other [Iteration] the other object to compare
    # @return [true, false]
    def ==(other)
      id == other.id
    end

    # Fetch the project the iteration belongs to
    #
    # @return [Project]
    def project
      @project ||= DataStore.find_project_by_id(project_id)
    end

    # Fetch the stories that belongs to the iteration
    #
    # @return [Stories] the stories collection
    def stories
      project.stories_in_iteration(self)
    end
  end
end
