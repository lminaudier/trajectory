Fabricator(:project, class_name: Trajectory::Project) do
  archived false
  created_at DateTime.now
  estimated_velocity 20
  historic_velocity [10, 9, 12, 13, 18]
  id { sequence(:id, 1) }
  keyword 'keyword'
  updated_at DateTime.now
  completed_iterations_count 10
  completed_stories_count 42
end
