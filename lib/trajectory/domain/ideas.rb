module Trajectory
  class Ideas < SimpleDelegator
    alias :ideas :__getobj__

    # Creates a new collection of {Idea}
    #
    # @param ideas [Array<Idea>] a arbitrary lenght list of {Idea} objects
    def initialize(*ideas)
      super(ideas)
    end

    # Create a new collection of {Idea} from a JSON array of attributes from trajectory API
    #
    # @param project [Project] the project the iterations belongs to
    # @param json_attributes [Hash] the hash of attributes of each idea of the collection
    def self.from_json(project, json_attributes)
      new(*json_attributes.map do |attributes|
        attributes = attributes.symbolize_keys!.merge({project_id: project.id})
        Idea.new(attributes)
      end)
    end
  end
end
