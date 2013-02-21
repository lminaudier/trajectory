require 'httparty'

class Api
  include HTTParty
  base_uri "http://www.apptrajectory.com/api/#{ENV['TRAJECTORY_API_KEY']}/accounts/#{ENV['TRAJECTORY_ACCOUNT_KEYWORD']}"

  def self.projects
    new.projects
  end

  def projects
    JSON.parse get_json("/projects.json")
  end

  private
  def get_json(url)
    get_body(url, options)
  end

  def options
    {:headers => {'Content-Type' => 'application/json'}}
  end

  def get_body(*args)
    self.class.get(*args).body
  end
end
