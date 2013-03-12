require "bundler/gem_tasks"

desc "List all code todos"
task :todo do
  require 'yard'
  YARD::Registry.load!.all.each do |o|
    if o.tag(:todo)
      puts "#{o.file}:#{o.line} #{o.tag(:todo).text}"
    end
  end
end
