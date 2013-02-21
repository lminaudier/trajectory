module Trajectory
  class Project
    include Virtus

    attribute :id, Integer, default: lambda { |project, attribute| raise MissingAttributeError.new(project, :id) }
    attribute :name, String
    attribute :archived, Boolean
    attribute :created_at, DateTime
    attribute :estimated_velocity, Integer
    attribute :historic_velocity, Array[Integer]
    attribute :keyword, String
    attribute :updated_at, DateTime
    attribute :completed_iterations_count, Integer
    attribute :completed_stories_count, Integer

    def ==(other)
      id == other.id
    end

    def stories
      @stories ||= DataStore.stories_for_project(self)
    end

    def total_points
      stories.inject(0) do |accumulator, story|
        accumulator += story.points
      end
    end
  end
end
