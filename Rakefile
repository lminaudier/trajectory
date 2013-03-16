require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--format progress'
end

task :default => :spec

desc "List all code todos"
task :todo do
  require 'yard'
  YARD::Registry.load!.all.each do |o|
    if o.tag(:todo)
      puts "#{o.file}:#{o.line} #{o.tag(:todo).text}"
    end
  end
end
