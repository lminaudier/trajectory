# Trajectory Ruby Wrapper

[![Build Status](https://travis-ci.org/lminaudier/trajectory.png?branch=master)](https://travis-ci.org/lminaudier/trajectory)

This gem is a wrapper to the Thoughbot's Trajectory app ([apptrajectory.com](http://apptrajectory.com)).

This is *work in progress* but you'll have read access to
- projects
- stories
- iterations
- ideas
- updates

Comments, Uploads wrappers are missing.

No write wrapper is provided at the moment.

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

	client = Trajectory::Client.new
	client.projects

#### API

See `lib/trajectory/domain/` for api details

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
