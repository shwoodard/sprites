require 'sprites/sprite'

module Sprites
  class Sprites
    def initialize(configuration)
      @configuration = configuration
      @sprites = Hash.new do |sprites, name|
        sprites[name] = Sprite.new(name, configuration)
      end
    end

    def [](sprite_identifier)
      @sprites.has_key?(sprite_identifier) == false ?
        nil :
        @sprites[sprite_identifier]
    end

    def clear
      @sprites.clear
    end

    def each(&blk)
      @sprites.values.each(&blk)
    end

    def empty?
      @sprites.empty?
    end

    def count
      @sprites.count
    end

    def add(name_or_sprite, options = {}, &blk)
      sprite = case name_or_sprite
      when Sprite
        @sprites[name_or_sprite.name] = name_or_sprite
      when Symbol, String
        @sprites[name_or_sprite.to_sym]
      else
        raise ArgumentError
      end

      sprite.configure(options, &blk)
    end
  end
end
