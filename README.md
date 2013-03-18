# Trajectory API Ruby Wrapper

[![Build Status](https://travis-ci.org/lminaudier/trajectory.png?branch=master)](https://travis-ci.org/lminaudier/trajectory)
[![Code Climate](https://codeclimate.com/github/lminaudier/trajectory.png)](https://codeclimate.com/github/lminaudier/trajectory)
[![Dependency Status](https://gemnasium.com/lminaudier/trajectory.png)](https://gemnasium.com/lminaudier/trajectory)
[![Coverage Status](https://coveralls.io/repos/lminaudier/trajectory/badge.png?branch=master)](https://coveralls.io/r/lminaudier/trajectory)

This gem is a wrapper to the Thoughbot's Trajectory app API ([apptrajectory.com](http://apptrajectory.com)).

This is **work in progress** but at the moment, you'll have read access to
- [Project](http://rdoc.info/gems/trajectory/Trajectory/Project)
- [Story](http://rdoc.info/gems/trajectory/Trajectory/Story)
- [Iteration](http://rdoc.info/gems/trajectory/Trajectory/Iteration)
- [Idea](http://rdoc.info/gems/trajectory/Trajectory/Idea)
- [Update](http://rdoc.info/gems/trajectory/Trajectory/Update)

The wrapper propose some handy methods on collections of [projects](http://rdoc.info/gems/trajectory/Trajectory/Projects), [stories](http://rdoc.info/gems/trajectory/Trajectory/Stories), [iterations](http://rdoc.info/gems/trajectory/Trajectory/Iterations) and [ideas](http://rdoc.info/gems/trajectory/Trajectory/Ideas).

Comments and Uploads wrappers are not yet implemented.
Wrapper for write access is not provided at the moment.

If you have questions, you can submit an issue or ping me on twitter [@lminaudier](https://twitter.com/lminaudier).

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
`TRAJECTORY_API_KEY` environment variable and for the account keyword in `TRAJECTORY_ACCOUNT_KEYWORD`.

	require 'trajectory'

	client = Trajectory::Client.new
	client.projects

#### API

See [RDoc](http://rdoc.info/gems/trajectory/frames) for api details

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
