# Load the rails application
require File.expand_path('../application', __FILE__)

require 'rake'
include Rake::DSL

SpritesRailsTestApp::Application.initialize!
