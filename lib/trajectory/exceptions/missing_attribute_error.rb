module Trajectory
  class MissingAttributeError < RuntimeError
    def initialize(object, attribute)
      @object = object
      @attribute = attribute.to_sym
    end

    def to_s
      "Attribute #{@attribute} of #{@object.inspect} is nil."
    end
  end
end
