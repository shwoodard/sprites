require 'active_support'
require 'active_support/core_ext'
require "sprites/version"

module Sprites
  extend ActiveSupport::Autoload

  autoload :Application
  autoload :Configuration
  autoload :Sprites
  autoload :Sprite
  autoload :SpritePieces
  autoload :SpritePiece
  autoload :Stylesheet
  autoload :ChunkyPngGenerator, 'sprites/sprite_generators/chunky_png_generator'

  class << self
    def application
      @application ||= Application.new(configuration)
    end

    def define(&blk)
      application.define(&blk)
    end

    def configure(&blk)
      @configuration ||= Configuration.new
      @configuration.configure(&blk) if block_given?
      @configuration
    end
    alias_method :configuration, :configure
  end
end
