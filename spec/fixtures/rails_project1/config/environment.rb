# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
# SpritesRailsTestApp::Application.initialize!

require 'rake'
include Rake::DSL
SpritesRailsTestApp::Application.load_tasks
