require 'mini_magick'
require 'fileutils'

module Sprites
  class MiniMagickGenerator < SpriteGenerator
    private

    def create_image_list(sprite, sprite_path, sprite_pieces, orientation)
      offset = 0

      image_list = sprite_pieces.map do |sp|
        sp_path = SpritePiece.sprite_piece_full_path(@configuration, sp)
        image = MiniMagick::Image.open(sp_path)
        sp.x = orientation == Sprite::Orientations::VERTICAL ? 0 : offset
        sp.y = orientation == Sprite::Orientations::VERTICAL ? offset : 0
        sp.width = image["width"]
        sp.height = image["height"]

        offset += orientation == Sprite::Orientations::VERTICAL ? image["height"] : image["width"]

        image
      end
      [image_list]
    end

    def create_sprite(sprite, sprite_path, sprite_pieces, image_list, width, height, orientation, verbose)
      begin
        tempfile = Tempfile.new(File.extname(sprite_path)[1..-1])
        tempfile.binmode
      ensure
        tempfile.close
      end

      options = {
        :tile => orientation == Sprite::Orientations::VERTICAL ? "1x#{sprite_pieces.count}" : "#{sprite_pieces.count}x1",
        :geometry => "+0+0",
        :background => "transparent",
        :mattecolor => '#bdbdbd'
      }

      args = options.map {|o, v| "-#{o} '#{v}'"}
      image_list.each {|img| args << img.path}
      args << tempfile.path

      MiniMagick::Image.new(image_list.first.path).run_command('montage', *args)
      # image_list.size.times { $stdout << '.' } if verbose
      # $stdout << "\n" if verbose
      @sprite = MiniMagick::Image.open(tempfile.path)
    end

    def write(path, quality = nil)
      FileUtils.mkdir_p(File.dirname(path))
      @sprite.write(path)
    end

    def finish
      @sprite.destroy! if @sprite
      @sprite = nil
    end
  end
end
