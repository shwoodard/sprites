require 'rspec'
require 'sprites'

include Sprites

ROOT = Sprites.gem_root

Dir['spec/support/*.rb'].each {|support_file| load support_file}

RSpec.configure do |config|
  config.include SpritesHelper
  config.after { ::Sprites.application.sprites.clear }
end
