module Sprites
  class SpriteGenerator
    SPRITE_GENERATORS = {
      :rmagick => RMagickGenerator,
      :oily_png => ChunkyPngGenerator,
      :chunky_png => ChunkyPngGenerator,
      :mini_magick => MiniMagickGenerator
    }

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

    def self.current(configuration = ::Sprites.configuration)
      generator =  SPRITE_GENERATORS[configuration.backend] if configuration.backend

      generator = begin
        require 'rmagick'
        SPRITE_GENERATORS[:rmagick]
      rescue LoadError
        begin
          require 'RMagick'
          SPRITE_GENERATORS[:rmagick]
        rescue LoadError
          begin
            require 'oily_png'
            SPRITE_GENERATORS[:chunky_png]
          rescue LoadError
            begin
              require 'chunky_png'
              SPRITE_GENERATORS[:chunky_png]
            rescue LoadError
              begin
                require 'mini_magick'
                SPRITE_GENERATORS[:mini_magick]
              rescue LoadError
              end
            end
          end
        end
      end unless generator

      raise Notifier.no_configured_or_imlicit_backend(false) unless generator
      generator.new(configuration)
    end

    private
    
    def create_image_list(sprite, sprite_path, sprite_pieces, orientation)
      raise NoMethodError
    end
  end
end
