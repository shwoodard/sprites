require "sprites/version"
require 'sprites/application'
require 'sprites/configuration'

module Sprites
  autoload :SpriteGenerator, 'sprites/sprite_generator'
  autoload :RMagickGenerator, 'sprites/sprite_generators/rmagick_generator'
  autoload :ChunkyPngGenerator, 'sprites/sprite_generators/chunky_png_generator'
  autoload :MiniMagickGenerator, 'sprites/sprite_generators/mini_magick_generator'
  

  class << self
    def application
      @application ||= Application.new(configuration)
    end

    def configure(&blk)
      @configuration ||= Configuration.new
      @configuration.configure(&blk) if block_given?
      @configuration
    end
    alias_method :configuration, :configure

    def gem_root
      Pathname.new(File.expand_path('../..', __FILE__))
    end
  end
end
