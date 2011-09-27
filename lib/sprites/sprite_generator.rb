require 'sprites/sprite_generators/rmagick_generator'
require 'sprites/sprite_generators/chunky_png_generator'
require 'sprites/sprite_generators/mini_magick_generator'

module Sprites
  class SpriteGenerator
    SPRITE_GENERATORS = {
      :rmagick => RMagickGenerator,
      :chunky_png => ChunkyPngGenerator,
      :mini_magick => MiniMagickGenerator
    }

    def self.current
      new
    end
  end
end
