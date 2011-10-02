require 'sprites/sprite_generator'
begin
  require 'rmagick'
rescue LoadError
  require 'RMagick'
end

module Sprites
  class RMagickGenerator < SpriteGenerator
    include Magick

    DEFAULT_SPRITE = Image.new(0,0).freeze

    private

    def create_image_list(sprite, sprite_path, sprite_pieces, orientation)
      sprite_piece_paths = sprite_pieces.map {|sp| File.join(@configuration.sprite_pieces_path, sp.path)}
      image_list = ImageList.new(*sprite_piece_paths)

      offset = 0

      image_list.each_with_index do |image, i|
        sprite_pieces.element_at(i).info = SpritePiece::Info.new(
          orientation == Sprite::Orientations::VERTICAL ? 0 : offset,
          orientation == Sprite::Orientations::VERTICAL ? offset : 0,
          image.columns,
          image.rows
        )
        offset += orientation == Sprite::Orientations::VERTICAL ? image.rows : image.columns
      end

      [image_list]
    end

    def create_sprite(sprite, sprite_path, sprite_pieces, image_list, width, height, orientation, verbose)
      @sprite = image_list.montage do
        self.tile = orientation == Sprite::Orientations::VERTICAL ? "1x#{sprite_pieces.count}" : "#{sprite_pieces.count}x1"
        self.geometry = "+0+0"
        self.background_color = 'transparent'
        # TODO support matte_color defined by sprite
        self.matte_color = '#bdbdbd'
      end
    
      # image_list.size.times { $stdout << '.' } if verbose
      # $stdout << "\n" if verbose
    end
    # 
    def write(path)
      FileUtils.mkdir_p(File.dirname(path))
      @sprite.write("#{File.extname(path)[1..-1]}:#{path}") do
        self.quality = 100
      end
    end
    
    def finish
      if @sprite
        @sprite.strip!
        @sprite.destroy! unless @sprite == DEFAULT_SPRITE
      end
      @sprite = DEFAULT_SPRITE
    end
  end
end
