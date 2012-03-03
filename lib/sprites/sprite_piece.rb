class Sprites
  class SpritePiece
    SUPPORTED_OPTIONS = %w(x y)

    attr_reader :path, :sprite
    attr_accessor :css_selector, :width, :height, :top, :left, *SUPPORTED_OPTIONS
    alias_method :selector, :css_selector

    def initialize(sprites, sprite, path)
      @sprites, @sprite = sprites, sprite
      @path = path
    end

    def configure(options)
      options.symbolize_keys!.assert_valid_keys(*(SUPPORTED_OPTIONS.map(&:intern)))

      options.each {|k,v| send(:"#{k}=", v) }
    end

    def background_property_url
      @sprite.background_property_url
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
  background:url('#{background_property_url}?#{Time.now.to_i}') no-repeat #{x || negative_pixelize(left)} #{y || negative_pixelize(top)};
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
