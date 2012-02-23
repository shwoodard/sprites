require 'rspec'
require 'rails' # load rails before sprites for the engine to be loaded
require 'sprites'

GEM_ROOT = Pathname(File.expand_path('../..', __FILE__))

Dir['spec/support/*.rb'].each {|support_file| require support_file}

RSpec.configure do |config|
  config.mock_with :mocha
  config.include SpritesHelper
  config.after(:each, :rails => false) { Sprites.reset! }
end
