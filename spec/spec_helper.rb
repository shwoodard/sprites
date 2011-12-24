require 'rspec'
require 'sprites'

include Sprites

GEM_ROOT = Pathname(File.expand_path('../..', __FILE__))

Dir['spec/support/*.rb'].each {|support_file| load support_file}

RSpec.configure do |config|
  config.include SpritesHelper
  config.after { ::Sprites.application.sprites.clear }
end
