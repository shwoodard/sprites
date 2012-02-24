class Sprites
  class SpritePiece
    attr_reader :path
    attr_accessor :sprite, :css_selector, :x, :y, :width, :height, :top, :left
    alias_method :selector, :css_selector

    def initialize(sprites, sprite, path)
      @sprites, @sprite = sprites, sprite
      @path = path
    end

    def asset_path
      @sprite.asset_path
    end

    def source_path
      File.join(@sprites.configuration.sprite_pieces_path, path)
    end

    def css
      <<-CSS
#{selector}
{
  display:block;
  width:#{width}px;
  height:#{height}px;
  background:url('#{asset_path}') no-repeat #{x || negative_pixelize(left)} #{y || negative_pixelize(top)};
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
