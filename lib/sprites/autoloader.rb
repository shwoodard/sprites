require 'sprites/sprite'

module Sprites
  class Autoloader
    def initialize(configuration = ::Sprites.configuration)
      @configuration = configuration
    end

    def autoload
      Dir[File.join(@configuration.sprite_pieces_path, '*')].each do |sprite_path|
        sprite = Sprite.new(File.basename(sprite_path).intern).configure
        ::Sprites.application.sprites.add(sprite) if File.directory?(sprite_path)
      end
    end
  end
end
