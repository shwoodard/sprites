module Sprites
  class SpritePiece
    attr_reader :path
    attr_accessor :css_selector, :x, :y, :width, :height
    alias_method :selector, :css_selector

    def initialize(path)
      @path = path
    end

    def self.sprite_piece_full_path(configuration, sprite_piece)
      File.join(configuration.sprite_pieces_path, sprite_piece.path)
    end

    def css(sprite)
      <<-CSS
#{selector}
{
  display:block;
  width:#{width}px;
  height:#{height}px;
  background:url('#{Sprite.sprite_css_path(configuration, sprite)}') no-repeat -#{x} -#{y}
}
      CSS
    end
  end
end
