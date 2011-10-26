begin
  require 'oily_png'
rescue
  require 'chunky_png'
end

module Sprites
  class ChunkyPngGenerator
    attr_reader :configuration

    def initialize(configuration)
      @configuration = configuration
    end
    
    def generate(sprites)
      # verbose = ENV['VERBOSE'] == 'true' || ENV['DEBUG']
      #       
      # if verbose
      #   t = Time.now
      #   $stdout << "#{t}: Active Sprites: \"I'm starting my run using #{runner_name}.\"\n" 
      #   $stdout << "\nSprites to create:\n\"#{@sprites.map(&:path).join('", "')}\"\n"
      # end
    
      sprites.each do |sprite|
        next if sprite.sprite_pieces.empty?
        # 
        # if verbose
        #   t_sprite = Time.now
        #   $stdout << "\n=================================================\n"
        #   $stdout << "Starting Sprite, #{sprite.path}\n"
        # end
        # 

        sprite_path = File.join(configuration.sprites_path, sprite.path)
        sprite_stylesheet_path = File.join(configuration.sprite_stylesheets_path, sprite.stylesheet_path)
        
        orientation = sprite.orientation
        sprite_pieces = sprite.sprite_pieces
        
        begin
        #   $stdout << "Gathering sprite details..." if verbose
          image_list, width, height = create_image_list(sprite, sprite_path, sprite_pieces, orientation)
        #   $stdout << "done.\n" if verbose
        # 
        #   if ENV['DEBUG']
        #     $stdout << "|\tpath\t|\tselectors\t|\tx\t|\ty\t|\twidth\t|\theight\t|\n"
        #     $stdout << "#{sprite_pieces.map(&:to_s).join("\n")}\n"
        #   end
        # 
          sprite.write_stylesheet(configuration)
        #   stylesheet_file_path = File.join(@railtie.config.paths.public.to_a.first, sprite_stylesheet_path)
        #   $stdout << "Writing stylesheet to #{stylesheet_file_path} ... " if verbose
        #   stylesheet.write stylesheet_file_path
        #   $stdout << "done.\n" if verbose
        # 
        #   $stdout << "Beginning sprite generation using #{runner_name.humanize}.\n" if verbose
          create_sprite(sprite, sprite_path, sprite_pieces, image_list, width, height, orientation, false)
        #   $stdout << "Success!\n" if verbose
        # 
        #   $stdout << "Writing sprite to #{sprite_file_path} ... " if verbose
          write sprite_path
        #   $stdout << "done.\n" if verbose
        # 
        #   $stdout << "Finished #{sprite.path} in #{Time.now - t_sprite} seconds.\n" if verbose
        #   $stdout << "=================================================\n\n" if verbose
        ensure
          finish
        end
      end

      # $stdout << "#{Time.now}: ActiveSprites \"I finished my run in #{Time.now - t} seconds.\"\n" if verbose
    end

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
