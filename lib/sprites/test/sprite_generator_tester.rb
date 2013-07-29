require 'rubygems'
require 'csspool'

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
      parser.rule_sets.each do |rule_set|
        background_property_urls << uri_expression_for_background(rule_set.declarations).split('?')[0]
      end
      background_property_urls
    end

    private
    def test_generate(gem_root = GEM_ROOT)
      sprite_pieces = @sprite.sprite_pieces
      sprite_image = Image.read(sprite.path).first

      sprite_pieces_with_selector_data = []

      parser.rule_sets.each do |rule_set|
        rules_set = Set.new(rule_set.selectors.map(&:to_s))
        #rules_set.map!(&:strip)
        sprite_piece = sprite_pieces.find do |sp|
          rules_set == Set.new(sp.css_selector.split(%r{,\s*}))
        end

        width = declaration_for_property(rule_set.declarations, 'width')[%r{\s*(\d+)(?:px)?;?$}, 1].to_i
        height = declaration_for_property(rule_set.declarations, 'height')[%r{\s*(\d+)(?:px)?;?$}, 1].to_i
        background = declaration_for_property(rule_set.declarations, 'background')[%r{\s*([^;]+)}, 1]
        x = background[%r{\s-?(\d+)(?:px)?\s}, 1].to_i
        y = background[%r{\s-?(\d+)(?:px)?$}, 1].to_i
        sprite_pieces_with_selector_data << [sprite_piece, Selector.new(rule_set.selectors, x, y, width, height)]
      end

      sprite_pieces_with_selector_data.map do |sp, selector_data|
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

          _, pd = curr_sprite_image.compare_channel(sprite_piece_image, MeanSquaredErrorMetric)
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
      CSSPool.CSS open(stylesheet_path)
    end

    def declaration_for_property(declarations, property)
      declarations.find {|declaration| property == declaration.property}.expressions.map(&:to_s).join(' ')
    end

    def uri_expression_for_background(declarations)
      decl = declarations.find {|declaration| 'background' == declaration.property }.expressions.find do |expression|
        expression.is_a?(CSSPool::Terms::URI)
      end
      decl && decl.value
    end
  end
end
