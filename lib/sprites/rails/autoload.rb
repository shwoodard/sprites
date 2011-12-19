require 'sprites/autoloader'

module Sprites
  unless defined?(Sprites::Railtie)
    raise 'Require "sprites/rails" before requiring "sprites/rails/autoload"'
  end

  class Railtie
    initializer 'sprites.autoload' do
      Sprites::Autoloader.new.autoload
    end
  end
end
