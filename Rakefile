require "bundler/gem_tasks"
require 'rspec/core/rake_task'

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "./spec/**/*_spec.rb" # don't need this, it's default.
  # Put spec opts in a file named .rspec in root
end

desc "Generate code coverage"
RSpec::Core::RakeTask.new(:coverage) do |t|
  t.pattern = "./spec/**/*_spec.rb" # don't need this, it's default.
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec']
end


namespace :spec do
  desc 'Create spec'
  task :create, :path do |t, args|
    spec_path = File.join('spec', args[:path].gsub(%r{.rb$}, '_spec.rb'))
    klass = File.basename(args[:path], File.extname(args[:path])).split('_').map {|s| "#{s[0,1].upcase}#{s[1..-1]}" }.join
    mkdir_p File.dirname(spec_path)

    spec_doc = <<-EOS
require 'spec_helper'

describe #{klass} do
end
EOS

    File.open(spec_path, 'w+') do |f|
      f.puts spec_doc
    end

    puts spec_doc
  end
end

task(:cucumber) { sh 'cucumber' }

desc 'Default: run specs.'
task :default => [:spec, :cucumber]
