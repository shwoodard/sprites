require 'active_support/core_ext/object/blank'

module Sprites
  class Stylesheet
    attr_reader :path
    attr_accessor :sprite_pieces

    def initialize(path)
      @path = path
    end

    def self.stylesheet_full_path(configuration, stylesheet)
      File.join(configuration.sprite_stylesheets_path, stylesheet.path)
    end

    def css(configuration, sprite, sprite_pieces)
      return unless sprite_pieces.present?
      sprite_pieces.css(configuration, sprite)
    end
  end
end
