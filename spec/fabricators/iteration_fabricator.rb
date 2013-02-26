Fabricator(:iteration, class_name: Trajectory::Iteration) do
  id { sequence }
  percent_complete 90.0
  started_stories_count 4
  created_at DateTime.now
  estimated_velocity 12
  delivered_stories_count 28
  updated_at DateTime.now
  unstarted_stories_count 31
  starts_on DateTime.now
  current false
  stories_count 59
  complete false
  accepted_points 51
  estimated_points 72
  comments_count 8
  accepted_stories_count 24
end
