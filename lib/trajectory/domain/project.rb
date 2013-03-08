module Trajectory
  class Project
    include Virtus

    NUMBER_OF_WORKING_DAYS_BY_WEEK = 5.0

    attr_writer :stories, :users_collection
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

    def iterations
      @iterations ||= DataStore.iterations_for_project(self)
    end

    def ideas
      @ideas ||= DataStore.ideas_for_project(self)
    end

    def users
      @users_collection ||= DataStore.users_for_project(self)
    end

    def updates(since: DateTime.now)
      DataStore.updates_for_project(self, since)
    end

    def find_user_by_id(id)
      users.find_by_id(id)
    end

    def stories_in_iteration(iteration)
      stories.in_iteration(iteration)
    end

    def total_points
      stories.inject(0) do |accumulator, story|
        accumulator += story.points
      end
    end

    def estimated_end_date
      Date.today + remaining_days
    end

    def remaining_days
      raise VelocityEqualToZeroError.new(self) if estimated_velocity_per_day == 0
      (remaining_points / estimated_velocity_per_day).ceil
    end

    def remaining_points
      stories.not_completed.inject(0) do |accumulator, story|
        accumulator += story.points
      end
    end

    def estimated_velocity_per_day
      estimated_velocity / 7.0
    end

    def remaining_working_days
      raise VelocityEqualToZeroError.new(self) if estimated_velocity_per_working_day == 0
      (remaining_points / estimated_velocity_per_working_day).ceil
    end

    def estimated_velocity_per_working_day
      estimated_velocity / NUMBER_OF_WORKING_DAYS_BY_WEEK
    end

    def percent_complete
      (accepted_points.to_f / total_points * 100.0).round(1)
    end

    def accepted_points
      total_points - remaining_points
    end
  end
end
