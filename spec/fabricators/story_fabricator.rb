Fabricator(:story, class_name: Trajectory::Story) do
  assignee_name 'An asignee'
  task_type 'Feature'
  position { sequence }
  created_at DateTime.now
  state_events []
  title 'A story title'
  design_needed true
  updated_at DateTime.now
  idea_subject 'the related idea subject'
  archived false
  points 1
  id { sequence }
  development_needed true
  deleted false
  user_name 'A user'
  comments_count 24
end
