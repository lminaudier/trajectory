# Trajectory Ruby Wrapper

This gem is a wrapper to the Thoughbot's Trajectory app ([apptrajectory.com](http://apptrajectory.com)).

## Installation

Add this line to your application's Gemfile:

    gem 'trajectory'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install trajectory

## Usage

### Read Access

#### Authentication

By default, the wrapper will look for the Trajectory API key in
`TRAJECTORY_API_KEY` environment variable. You can also pass it directly to the
constructor.

	require 'trajectory'

	client = Trajectory.new

#### Projects

To retrieve all projects use :

	projects = client.projects

`projects` is an `Enumerable`. It adds the following API.

	projects.by_keyword('keyword')
	projects.archived / projects.active

When you have retrieved a project, you can access project attributes

	project.archived?
	project.created_at
	project.estimated_velocity
	project.historic_velocity
	project.id
	project.keyword
	project.updated_at
	project.completed_iterations_count
	project.completed_stories_count
	
	project.total_points
	project.estimated_end_date
	project.stories.unestimated
	project.percent_complete

#### Users

You can also access to users that have access to the project

	users = project.users

`users` is also an `Enumerable`.

When you access an individual user, you have access to its attributes using :

	user.created_at
	user.email
	user.id
	user.name
	user.updated_at
	user.gravatar_url

#### Stories

To retrieve all stories of a project use :

	project.stories

Or a subset of stories using

    project.stories.until(story)
    project.stories.before(story)
    project.stories.after(story)
    project.stories.completed
    project.stories.started
    project.stories.not_yet_started
    project.stories.in_current_iteration
    project.stories.started.in_current_iteration
    project.stories.not_yet_started.in_current_iteration

This returns an `Enumerable`.

Each individual story expose this attributes :

	story.assignee_name
	story.task_type
	story.position
	story.created_at
	story.state_events
	story.title
	story.design_needed?
	story.assignee
	story.updated_at
	story.idea_subject
	story.archived?
	story.points
	story.id
	story.development_needed?
	story.deleted?
	story.user
	story.user_name
	story.comments_count
	story.iteration
	story.idea
	story.state

#### Iterations

To retrieve all iterations of a project use :

	project.iterations
	
Or a subset using

	project.iterations.past
	project.iterations.current
	project.iterations.future

It returns an `Enumerable`

Each iteration has the following attributes

	iteration.percent_complete
	iteration.started_stories_count
	iteration.created_at
	iteration.estimated_velocity
	iteration.delivered_stories_count
	iteration.updated_at
	iteration.unstarted_stories_count
	iteration.starts_on
	iteration.current?
	iteration.stories_count
	iteration.id
	iteration.complete?
	iteration.accepted_points
	iteration.estimated_points
	iteration.comments_count
	iteration.accepted_stories_count
	
	iteration.stories.completed
	iteration.stories.started
	iteration.stories.not_yet_started

#### Ideas

To retrieve all ideas of a project use :

	project.ideas

Or a subset using	

	project.ideas.completed
	project.ideas.started
	project.ideas.not_yet_started

This return an `Enumerable`.

Each individual idea has the following attributes

	idea.stories_count
	idea.comments_count
	idea.last_comment_user_name
	idea.last_comment_created_at
	idea.editable_by_current_user?
	idea.stories
	idea.user
	idea.subscribed_user_ids
	
	idea.percent_complete

#### Uploads

From the idea, you can access to its uploads using

	idea.uploads

Each individual upload has the following attributes

	upload.id
	upload.created_at
	upload.updated_at
	upload.file_name
	upload.file_content_type
	upload.file_size":91816,
	upload.file_updated_at
	upload.original_url
	upload.thumb_url
	upload.extension
	upload.image?

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request