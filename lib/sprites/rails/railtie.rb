require 'rails/railtie'
require 'sprites'

module Sprites
  class Railtie < Rails::Railtie
    rake_tasks do
      load File.expand_path('../sprites.rake', __FILE__)
    end
  end
end
