require 'fileutils'
require 'active_support/core_ext'
require 'sprites/sprite_pieces'
require 'sprites/sprite_piece'
require 'sprites/stylesheet'

class Sprites
  class Sprite
    class InvalidOrientation < StandardError; end
    module Orientations
      VERTICAL = 1
      HORIZONTAL = 2
    end

    DEFAULT_OPTIONS = {
      :orientation => Orientations::VERTICAL,
      :path => lambda {|sprite| "#{sprite.name}.png" },
      :stylesheet_path => lambda {|sprite| sprite.stylesheet.path },
      :auto_define => true,
      :css_prefix => ''
    }

    attr_reader :name, :sprite_pieces, :stylesheet
    attr_writer :path, :stylesheet_path, :url, :auto_define, :css_prefix

    def initialize(name, sprites)
      @name, @sprites = name, sprites

      @sprite_pieces = SpritePieces.new(@sprites, self)
      @stylesheet = Stylesheet.new(self)
    end

    def orientation=(val)
      raise InvalidOrientation unless [Orientations::VERTICAL, Orientations::HORIZONTAL].include?(val)
      @orientation = val
    end

    [:path, :stylesheet_path, :url].each do |attribute|
      eval <<-EVAL
        def #{attribute}
          val = @#{attribute} || DEFAULT_OPTIONS[:#{attribute}]
          if val.respond_to?(:call)
            val.call(self)
          else
            val
          end
        end
      EVAL
    end

    def method_missing(meth, *args)
      unless [:orientation, :auto_define?, :css_prefix].include?(meth)
        super
      else
        instance_variable_get(:"@#{meth.to_s.chomp('?')}") || DEFAULT_OPTIONS[:"#{meth.to_s.chomp('?')}"]
      end
    end

    def configure(options = {}, &blk)
      options.symbolize_keys!.assert_valid_keys(*DEFAULT_OPTIONS.keys)
      options.each {|k,v| send(:"#{k}=", v)}
      auto_define! if auto_define?
      instance_eval(&blk) if block_given?
      self
    end

    def write_stylesheet(configuration, sprite_pieces = @sprite_pieces)
      path = Stylesheet.stylesheet_full_path(configuration, stylesheet)
      FileUtils.mkdir_p(File.dirname(path))
      File.open path, 'w+' do |f|
        f << stylesheet.css(sprite_pieces)
      end
    end

    def sprite_piece(path, css_class = nil, options = {})
      css_class ||= File.basename(path, File.extname(path)).split('/').join('-')
      @sprite_pieces.add(path, css_class, options)
    end

    def self.sprite_full_path(configuration, sprite)
      File.join(configuration.sprites_path, sprite.path)
    end

    def self.sprite_css_path(configuration, sprite)
      # TODO only works for rails and sprites dir is hard coded
      # TODO what if there is another app in the path
      "/assets/sprites/#{File.basename(sprite_full_path(configuration, sprite))}"
    end

    def auto_define!
      Dir[File.join(@sprites.configuration.sprite_pieces_path, name.to_s, '*.png')].each do |path|
        sprite_piece "#{name}/#{File.basename(path)}", ".#{File.basename(path, File.extname(path))}"
      end
    end

    def stylesheet_path
      @stylesheet_path || path.to_s.gsub(/png$/, 'css')
    end

    def asset_path
      url || File.join(@sprites.configuration.sprite_asset_path, path)
    end
  end
end
