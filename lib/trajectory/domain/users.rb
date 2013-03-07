module Trajectory
  class Users < SimpleDelegator
    alias :users :__getobj__

    def initialize(*args)
      super(args)
    end

    def find_by_id(id)
      users.find { |user| user.id == id } || false
    end
  end
end
