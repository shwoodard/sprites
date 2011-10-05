require 'rubygems'
require 'css_parser'
begin
  require 'rmagick'
rescue LoadError
  require 'RMagick'
end

module Sprites
  class SpriteGeneratorTester
    include Magick

    Selector = Struct.new(:selector, :x, :y, :width, :height)

    attr_reader :sprite, :configuration
    private :sprite, :configuration

    def initialize(sprite, configuration)
      @sprite, @configuration = sprite, configuration
    end

    def accurate?
      test_generate.all? {|x| x == 0}
    end

    private
    def test_generate
      orientation = @sprite.orientation
      sprite_pieces = @sprite.sprite_pieces
      sprite_image = Image.read(Sprite.sprite_full_path(configuration, sprite)).first

      stylesheet_path = Stylesheet.stylesheet_full_path(configuration, sprite.stylesheet)
      stylesheet_absolute_path = ::Sprites.gem_root.join(stylesheet_path)
      parser = CssParser::Parser.new
      parser.load_file!(File.basename(stylesheet_absolute_path), File.dirname(stylesheet_absolute_path), :screen)

      sprite_pieces_with_selector_data = []

      parser.each_rule_set do |rs|
        rules_set = Set.new(rs.selectors)
        rules_set.map!(&:strip)
        sprite_piece = sprite_pieces.find do |sp|
          rules_set == Set.new(sp.css_selector.split(%r{,\s*}))
        end
        width = rs['width'][%r{\s*(\d+)(?:px)?;?$}, 1].to_i
        height = rs['height'][%r{\s*(\d+)(?:px)?;?$}, 1].to_i
        background = rs['background'][%r{\s*([^;]+)}, 1]
        x = background[%r{\s-?(\d+)(?:px)?\s}, 1].to_i
        y = background[%r{\s-?(\d+)(?:px)?$}, 1].to_i
        sprite_pieces_with_selector_data << [sprite_piece, Selector.new(rs.selectors, x, y, width, height)]
      end

      percent_diferences = sprite_pieces_with_selector_data.map do |sp, selector_data|
        begin
          raise selector_data.inspect if sp.nil?
          sprite_piece_path = ::Sprites.gem_root.join(SpritePiece.sprite_piece_full_path(configuration, sp))
          sprite_piece_image = Image.read(sprite_piece_path).first
          
          curr_sprite_image = sprite_image.crop(
            selector_data.x,
            selector_data.y,
            selector_data.width,
            selector_data.height
          )
          diff_iamge, pd = curr_sprite_image.compare_channel(sprite_piece_image, MeanSquaredErrorMetric)
          pd
        ensure
          sprite_piece_image.destroy! if sprite_piece_image
          curr_sprite_image.destroy! if curr_sprite_image
          curr_sprite_image = nil
          sprite_piece_image = nil
        end
      end
    ensure
      sprite_image.destroy! if sprite_image
      sprite_image = nil
    end
  end
end
