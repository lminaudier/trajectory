module Trajectory
  class Ideas < SimpleDelegator
    alias :ideas :__getobj__

    # Creates a new collection of {Idea}
    #
    # @param ideas [Array<Idea>] a arbitrary lenght list of {Idea} objects
    # :nocov:
    def initialize(*ideas)
      super(ideas)
    end

    def self.from_json(project, json_attributes)
      new(*json_attributes.map do |attributes|
        attributes = attributes.symbolize_keys!.merge({project_id: project.id})
        Idea.new(attributes)
      end)
    end
  end
end
