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
  end
end
