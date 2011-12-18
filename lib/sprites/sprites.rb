require 'sprites/sprite'

module Sprites
  class Sprites
    def initialize(configuration)
      @configuration = configuration
      @sprites = Hash.new do |sprites, name|
        sprites[name] = Sprite.new(name)
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
      @sprites.size
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

    private

    def sprite_name(*args)
      return args.first if args.first.is_a?(Symbol)

      path = case args.first
      when String
        args.first
      when Hash
        # This is for when sprite is used like,
        # sprite 'path_to_sprite' => 'path_to_stylesheet', :option => value
        args.first.find {|k,v| k.is_a?(String)}.first
      end

      File.basename(path, File.extname(path)).intern
    end
  end
end
