require 'fileutils'
require 'active_support/core_ext'
require 'sprites/sprite_pieces'
require 'sprites/sprite_piece'
require 'sprites/stylesheet'

require 'forwardable'

class Sprites
  class Sprite
    class InvalidOrientation < StandardError; end
    module Orientations
      VERTICAL = 1
      HORIZONTAL = 2
    end

    SUPPORTED_OPTIONS = %w{orientation path stylesheet_path url autoload css_prefix}

    DEFAULT_OPTIONS = {
      :orientation => Orientations::VERTICAL,
      :css_prefix => ''
    }

    extend Forwardable

    attr_reader :name, :sprite_pieces, :stylesheet
    attr_accessor *SUPPORTED_OPTIONS

    def_delegator :@sprites, :configuration

    def initialize(name, sprites)
      @name, @sprites = name, sprites

      @sprite_pieces = SpritePieces.new(@sprites, self)
      @stylesheet = Stylesheet.new(self)
    end

    def orientation=(val)
      raise InvalidOrientation unless [Orientations::VERTICAL, Orientations::HORIZONTAL].include?(val)
      @orientation = val
    end

    def sprite_file_name
      "#{name}.png"
    end

    def stylesheet_file_name
      sprite_file_name.gsub(/png$/, 'css')
    end

    def background_property_url
      @url || File.join(@sprites.configuration.sprite_asset_path, sprite_file_name)
    end

    def path
      File.join(@sprites.configuration.sprites_path, @path || sprite_file_name)
    end

    def stylesheet_path
      File.join(@sprites.configuration.sprite_stylesheets_path, @stylesheet_path || stylesheet_file_name)
    end

    def do_autolaod?
      if autoload == false
        false
      else
        @sprites.configuration.autoload
      end
    end

    def css_prefix
      @css_prefix || DEFAULT_OPTIONS[:css_prefix]
    end

    def orientation
      @orientation || DEFAULT_OPTIONS[:orientation]
    end

    def configure(options = {}, &blk)
      options.symbolize_keys!.assert_valid_keys(*(SUPPORTED_OPTIONS.map(&:intern)))

      options.each {|k,v| send(:"#{k}=", v)}

      autoload! if do_autolaod?

      instance_eval(&blk) if block_given?

      self
    end

    def write_stylesheet(configuration, sprite_pieces = @sprite_pieces)
      FileUtils.mkdir_p(File.dirname(stylesheet_path))
      File.open stylesheet_path, 'w+' do |f|
        f << stylesheet.css(sprite_pieces)
      end
    end

    ## 
    # The +sprite_piece+ method adds sprite_piecess to the sprite
    #
    # === Example ===
    # sprite :foo do
    #   sprite_piece 'buttons/btn-black-default-28.png', 'a.black.wf_button > span, button.black.wf_submit span'
    #
    # Arguments:
    # [String] the path to sprite piece relatie to config.sprite_pieces_path
    # [String] (optional) the css selector to use for this sprite piece
    #
    # Options:
    ##
    def sprite_piece(path, css_class = nil, options = {})
      css_class ||= File.basename(path, File.extname(path)).split('/').join('-')
      @sprite_pieces.add(path, css_class, options)
    end

    def autoload!
      Dir[File.join(@sprites.configuration.sprite_pieces_path, name.to_s, '*.png')].each do |path|
        sprite_piece "#{name}/#{File.basename(path)}", ".#{File.basename(path, File.extname(path))}"
      end
    end

  end
end
