require 'pathname'
require 'sprites/core_ext/pathname'
require 'active_support/core_ext/array/extract_options'
require 'active_support/core_ext/object/try'
require 'sprites/sprite_piece'
require 'sprites/stylesheet'

module Sprites
  class Sprite
    class InvalidOrientation < StandardError; end
    module Orientations
      VERTICAL = 1
      HORIZONTAL = 2
    end

    extend Forwardable

    OPTIONS = [:orientation]

    DEFAULT_OPTIONS = {
      :orientation => Orientations::VERTICAL
    }

    attr_reader :name, :sprite_pieces

    def_delegator :@stylesheet, :stylesheet_path

    def initialize(name)
      @name = name
      @sprite_pieces = SpritePieces.new
      @options = DEFAULT_OPTIONS.dup
      set_options
    end

    def define(*args, &blk)
      @options = @options.merge args.extract_options!
      path(@options, *args)
      @stylesheet ||= Stylesheet.new(css_path)
      @options.delete(@path.to_s)
      set_options

      instance_eval(&blk) if block_given?
    end

    def is_defined?
      !@stylesheet.nil?
    end

    def stylesheet
      define unless is_defined?
      @stylesheet
    end

    def sprite_piece(options)
      @sprite_pieces.add(options)
    end

    def orientation(*args)
      val, *_ = args
      if val
        unless [Orientations::VERTICAL, Orientations::HORIZONTAL].include?(val)
          raise InvalidOrientation
        end
        @orientation = val
        return self
      end

      @orientation
    end

    def path(options = @options, *args)
      @path ||= Pathname.wrap(path_for_arguments(options, *args))
    end

    def self.sprite_full_path(configuration, sprite)
      File.join(configuration.images_path, sprite.path)
    end

    private

    def css_path
      @paths && @paths.last || @path.to_s.gsub(/png$/, 'css')
    end

    def paths_for_options(options)
      @paths ||= options.find {|k,v| k.is_a?(String) }
    end

    def path_for_arguments(options, *args)
      if args.first.is_a?(Symbol) || (args.empty? && !paths_for_options(options).try(:first))
        "sprites/#{args.first || @name}.png"
      elsif args.first.is_a?(String)
        args.first
      else
        path = paths_for_options(options).first
        raise ArgumentError, "Path is not a string.  See usage." unless path.is_a?(String)
        path
      end
    end
  end

  def set_options
    return unless @options
    @options.each {|k,v| send(k,v)}
  end
end
