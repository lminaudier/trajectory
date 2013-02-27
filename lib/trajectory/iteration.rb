module Trajectory
  class Iteration
    include Virtus

    attribute :id, Integer, default: lambda { |project, attribute| raise MissingAttributeError.new(project, :id) }
    attribute :percent_complete, Float
    attribute :started_stories_count, Integer
    attribute :created_at, DateTime
    attribute :estimated_velocity, Integer
    attribute :delivered_stories_count, Integer
    attribute :updated_at, DateTime
    attribute :unstarted_stories_count, Integer
    attribute :starts_on, DateTime
    attribute :current, Boolean
    attribute :stories_count, Integer
    attribute :complete, Boolean
    attribute :accepted_points, Integer
    attribute :estimated_points, Integer
    attribute :comments_count, Integer
    attribute :accepted_stories_count, Integer
    attribute :project_id, Integer

    def ==(other)
      id == other.id
    end

    def project
      DataStore.find_project_by_id(project_id)
    end
  end
end
