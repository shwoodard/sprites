class Sprites
  class SpritePiece
    attr_reader :path
    attr_accessor :sprite, :css_selector, :x, :y, :width, :height, :top, :left
    alias_method :selector, :css_selector

    def initialize(path)
      @path = path
    end

    def self.sprite_piece_full_path(configuration, sprite_piece)
      File.join(configuration.sprite_pieces_path, sprite_piece.path)
    end

    def css(configuration = Sprites.configuration, sprite = @sprite, sprite_css_path = nil)
      raise "Sprite needed." unless sprite

      <<-CSS
#{selector}
{
  display:block;
  width:#{width}px;
  height:#{height}px;
  background:url('#{sprite_css_path || Sprite.sprite_css_path(configuration, sprite)}') no-repeat #{x || negative_pixelize(left)} #{y || negative_pixelize(top)};
}
      CSS
    end

    private

    def negative_pixelize(val)
      return "0" if val.to_i == 0
      "-#{val}px"
    end
  end
end
