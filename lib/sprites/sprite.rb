require 'fileutils'
require 'active_support/core_ext'
require 'sprites/sprite_pieces'
require 'sprites/sprite_piece'
require 'sprites/stylesheet'

module Sprites
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
      :url => lambda {|sprite| sprite.stylesheet.url },
      :auto_define => true,
      :css_prefix => ''
    }

    attr_reader :name, :sprite_pieces, :stylesheet
    attr_writer :path, :stylesheet_path, :url, :auto_define, :css_prefix

    def initialize(name, configuration = ::Sprites.configuration)
      @name, @configuration = name, configuration
      @sprite_pieces = SpritePieces.new
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
      options.symbolize_keys!.assert_valid_keys(:path, :stylesheet_path, :url, :auto_define)
      options.each {|k,v| send(:"#{k}=", v)}
      auto_define! if auto_define?
      instance_eval(&blk) if block_given?
      self
    end

    def write_stylesheet(configuration, sprite_pieces = @sprite_pieces)
      path = Stylesheet.stylesheet_full_path(configuration, stylesheet)
      FileUtils.mkdir_p(File.dirname(path))
      File.open path, 'w+' do |f|
        f << stylesheet.css(configuration, self, sprite_pieces)
      end
    end

    def sprite_piece(path, css_class, options = {})
      @sprite_pieces.add(path, css_class, options)
    end

    def self.sprite_full_path(configuration, sprite)
      File.join(configuration.sprites_path, sprite.path)
    end

    def self.sprite_css_path(configuration, sprite)
      "/#{sprite_full_path(configuration, sprite)}"
    end

    def auto_define!
      Dir[File.join(@configuration.sprite_pieces_path, name.to_s, '*.png')].each do |path|
        sprite_piece "#{name}/#{File.basename(path)}", ".#{File.basename(path, File.extname(path))}"
      end
    end

    def stylesheet_path
      @stylesheet_path || path.to_s.gsub(/png$/, 'css')
    end
  end
end
