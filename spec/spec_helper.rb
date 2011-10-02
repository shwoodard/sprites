require 'rspec'
require 'sprites'

include Sprites

Dir['spec/support/*.rb'].each {|support_file| require support_file}

RSpec.configure do |config|
  config.include SpritesHelper
end
