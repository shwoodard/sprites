require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new :spec
Cucumber::Rake::Task.new

desc 'Default: run specs and features.'
task :default => [:spec, :cucumber]
