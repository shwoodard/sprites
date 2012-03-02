require 'rubygems'
require 'css_parser'
begin
  require 'rmagick'
rescue LoadError
  require 'RMagick'
end

class Sprites
  class SpriteGeneratorTester
    include Magick

    Selector = Struct.new(:selector, :x, :y, :width, :height)

    attr_reader :sprite
    private :sprite

    def initialize(sprite)
      @sprite = sprite
    end

    def accurate?
      test_generate.all? {|x| x == 0}
    end

    def background_property_urls
      background_property_urls = []
      parser.each_rule_set do |rs|
        background_property_urls << rs['background'][%r{url\('?(.+)(?:\?\d+)(?:')\)}, 1]
      end
      background_property_urls
    end

    private
    def test_generate(gem_root = GEM_ROOT)
      sprite_pieces = @sprite.sprite_pieces
      sprite_image = Image.read(sprite.path).first

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
          sprite_piece_path = sp.source_path
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

    def parser
      stylesheet_path = sprite.stylesheet_path
      parser = CssParser::Parser.new
      parser.load_file!(File.basename(stylesheet_path), File.dirname(stylesheet_path), :screen)
      parser
    end

  end
end
