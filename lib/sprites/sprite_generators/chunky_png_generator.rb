require 'sprites/sprite_generator'

begin
  require 'oily_png'
rescue
  require 'chunky_png'
end

module Sprites
  class ChunkyPngGenerator < SpriteGenerator
    private

    def create_image_list(sprite, sprite_path, sprite_pieces, orientation)
      width, height = 0, 0

      image_list = sprite_pieces.map do |sp|
        sprite_piece_path = SpritePiece.sprite_piece_full_path(@configuration, sp)
        sp_image =  ChunkyPNG::Image.from_file(sprite_piece_path)
        sp.x = orientation == Sprite::Orientations::VERTICAL ? 0 : width
        sp.y = orientation == Sprite::Orientations::VERTICAL ? height : 0
        sp.width = sp_image.width
        sp.height = sp_image.height

        width = orientation == Sprite::Orientations::HORIZONTAL ? width + sp_image.width : [width, sp_image.width].max
        height = orientation == Sprite::Orientations::VERTICAL ? height + sp_image.height : [height, sp_image.height].max

        sp_image
      end
      [image_list, width, height]
    end

    def create_sprite(sprite, sprite_path, sprite_pieces, image_list, width, height, orientation, verbose)
      @sprite = ChunkyPNG::Image.new(width, height, ChunkyPNG::Color::TRANSPARENT)

      image_list.each_with_index do |image, i|
        @sprite.replace!(image, sprite_pieces.element_at(i).x, sprite_pieces.element_at(i).y)
        # $stdout << '.' if verbose
      end
      # $stdout << "\n" if verbose
    end

    def write(path, quality = nil)
      FileUtils.mkdir_p(File.dirname(path))
      @sprite.save(path)
    end

    def finish
      @sprite = nil
    end
  end
end
