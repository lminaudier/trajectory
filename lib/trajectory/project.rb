module Trajectory
  class Project
    include Virtus

    NUMBER_OF_WORKING_DAYS_BY_WEEK = 5.0

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

    def total_points
      stories.inject(0) do |accumulator, story|
        accumulator += story.points
      end
    end

    def estimated_end_date
      Date.today + remaining_days
    end

    def remaining_days
      begin
        (remaining_points / estimated_velocity_per_day).ceil
      rescue FloatDomainError
        'This project will never end'
      end
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
      begin
        (remaining_points / estimated_velocity_per_working_day).ceil
      rescue FloatDomainError
        'This project will never end'
      end
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
