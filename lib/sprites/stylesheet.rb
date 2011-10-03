require 'active_support/core_ext/object/blank'

module Sprites
  class Stylesheet
    attr_reader :path
    attr_accessor :sprite_pieces

    def initialize(path, sprite = nil)
      @path, @sprite = path, sprite
    end

    def self.stylesheet_full_path(configuration, stylesheet)
      File.join(configuration.sprite_stylesheets_path, stylesheet.path)
    end

    def css(configuration = Sprites.configuration, sprite = @sprite, sprite_pieces = @sprite_pieces)
      return unless sprite_pieces.present?

      sprite_pieces.css(configuration, sprite)
    end
  end
end
