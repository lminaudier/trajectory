module Trajectory
  class Idea
    include Virtus

    attribute :id, Integer, default: lambda { |project, attribute| raise MissingAttributeError.new(project, :id) }
    attribute :stories_count, Integer
    attribute :comments_count, Integer
    attribute :last_comment_user_name, String
    attribute :last_comment_created_at, DateTime
    attribute :editable_by_current_user, Boolean
    attribute :user_id, Integer
    attribute :subscribed_user_ids, Array[Integer]
    attribute :project_id, Integer

    def ==(other)
      id == other.id
    end

    def project
      DataStore.find_project_by_id(project_id)
    end
  end
end
