# loads test api keys

require 'yaml'

env_file = File.expand_path('../../config/env.yml', __FILE__)
api_keys = YAML.load_file(env_file)
trajectory_api_key = api_keys['test']['trajectory_api_key']
trajectory_account_keyword = api_keys['test']['trajectory_account_keyword']

ENV['TRAJECTORY_API_KEY'] = trajectory_api_key
ENV['TRAJECTORY_ACCOUNT_KEYWORD'] = trajectory_account_keyword

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
end

require 'fabrication'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
end

require 'trajectory'
