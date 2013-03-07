module Trajectory
  class User
    include Virtus

    attribute :id, Integer, default: lambda { |project, attribute| raise MissingAttributeError.new(project, :id) }
    attribute :name, String
    attribute :created_at, DateTime
    attribute :updated_at, DateTime
    attribute :gravatar_url, String
    attribute :email, String

    def ==(other)
      id == other.id
    end
  end
end
