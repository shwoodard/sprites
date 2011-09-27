module Sprites
  class SpriteGenerator
    SPRITE_GENERATORS = {
      :rmagick => RMagickGenerator,
      :chunky_png => ChunkyPngGenerator,
      :mini_magick => MiniMagickGenerator
    }

    attr_reader :configuration

    def initialize(configuration)
      @configuration = configuration
    end

    def self.current(configuration = ::Sprites.configuration)
      return SPRITE_GENERATORS[configuration.backend].new(configuration) if configuration.backend

      begin
        require 'rmagick'
        return SPRITE_GENERATORS[:rmagick].new(configuration)
      rescue LoadError
        begin
          require 'RMagick'
          return SPRITE_GENERATORS[:rmagick].new(configuration)
        rescue LoadError
          begin
            require 'oily_png'
            return SPRITE_GENERATORS[:chunky_png].new(configuration)
          rescue LoadError
            begin
              require 'chunky_png'
              return SPRITE_GENERATORS[:chunky_png].new(configuration)
            rescue LoadError
              begin
                require 'mini_magick'
                return SPRITE_GENERATORS[:mini_magick].new(configuration)
              rescue LoadError
              end
            end
          end
        end
      end

      raise Notifier.no_configured_or_imlicit_backend(false)
    end
  end
end
