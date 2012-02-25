require 'active_support/core_ext/object/blank'

class Sprites
  class Stylesheet
    attr_reader :path
    attr_accessor :sprite_pieces

    def initialize(sprite)
      @sprite = sprite
    end

    def path
      @sprite.stylesheet_path
    end

    def css(sprite_pieces = @sprite_pieces)
      return unless sprite_pieces.present?

      sprite_pieces.css
    end
  end
end
