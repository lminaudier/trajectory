module Trajectory
  class Iterations < SimpleDelegator
    alias :iterations :__getobj__

    # Creates a new collection of {Iteration}
    #
    # @param iterations [Array<Iteration>] a arbitrary lenght list of {Iteration} objects
    def initialize(*iterations)
      super(iterations)
    end

    # Create a new collection of {Iteration} from a JSON array of attributes from trajectory API
    #
    # @param project [Project] the project the iterations belongs to
    # @param json_attributes [Hash] the hash of attributes of each iteration of the collection
    def self.from_json(project, json_attributes)
      new(*json_attributes.map do |attributes|
        attributes = attributes.symbolize_keys!.merge({project_id: project.id})
        attributes[:current] = attributes[:current?]
        attributes.delete(:current?)
        Iteration.new(attributes)
      end)
    end

    # Fetch the iteration with the given id in the collection. If it is not found,
    # it returns false
    #
    # @param id [Integer] the project id
    # @return [Iteration, false] the found iteration or false
    def find_by_id(id)
      iterations.find { |iteration| iteration.id == id } || false
    end

    # Returns the current iteration of the project or false it no current iteration can be found
    #
    # @return [Iteration, false] the current iteration or false
    def current
      iterations.find { |iteration| iteration.current? } || false
    end

    # Returns the future iterations of the project
    #
    # @return [Iterations] the future iterations
    def future
      iterations.select { |iteration| iteration.future? }
    end

    # Returns the past iterations of the project
    #
    # @return [Iterations] the past iterations
    def past
      iterations.select { |iteration| iteration.past? }
    end
  end
end
