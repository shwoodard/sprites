require 'pathname'
require 'sprites/core_ext/pathname'
require 'active_support/core_ext/array/extract_options'
require 'sprites/sprite_piece'
require 'sprites/stylesheet'

module Sprites
  class Sprite
    extend Forwardable

    attr_reader :name, :path, :sprite_pieces, :stylesheet

    def_delegator :@stylesheet, :stylesheet_path

    def initialize(name)
      @name = name
      @sprite_pieces = SpritePieces.new
    end

    def define(*args, &blk)
      @options ||= args.extract_options!
      @path ||= Pathname.wrap(path_for_arguments(@options, *args))
      @stylesheet ||= Stylesheet.new(css_path)
      @options.delete(@path.to_s)

      instance_eval(&blk)
    end

    def sprite_piece(options)
      @sprite_pieces.add(options)
    end

    private

    def css_path
      @paths && @paths.last || @path.to_s.gsub(/png$/, 'css')
    end

    def paths_for_options(options)
      @paths ||= options.find {|k,v| k.is_a?(String) }
    end

    def path_for_arguments(options, *args)
      if args.first.is_a?(Symbol)
        "sprites/#{args.first}.png"
      else
        # args are empty indicates that the method was called
        # with a hash--options--as the first argument
        path = args.first || paths_for_options(options).first
        raise ArgumentError, "Path is not a string.  See usage." unless path.is_a?(String)
        path
      end
    end
  end
end
