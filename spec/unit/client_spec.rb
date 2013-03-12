require 'spec_helper'

module Trajectory
  describe Client do
    it 'raises an exceptions when environment variables are not set' do
      begin
        original_api_key = ENV['TRAJECTORY_API_KEY']
        original_account_keyword = ENV['TRAJECTORY_ACCOUNT_KEYWORD']
        ENV['TRAJECTORY_API_KEY'] = nil
        ENV['TRAJECTORY_ACCOUNT_KEYWORD'] = nil

        expect do
          Client.new
        end.to raise_error(BadEvnrionmentError)
      ensure
        ENV['TRAJECTORY_API_KEY'] = original_api_key
        ENV['TRAJECTORY_ACCOUNT_KEYWORD'] = original_account_keyword
      end
    end

    it 'delegate fetching of projects to the data store' do
      DataStore.should_receive(:projects)

      Client.new.projects
    end
  end
end
