module Trajectory
  class Projects < Array
    def find_by_keyword(keyword)
      detect { |project| project.keyword == keyword } || false
    end

    def archived
      select { |project| project.archived? }
    end

    def active
      select { |project| !project.archived? }
    end
  end
end


