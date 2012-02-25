require 'active_support/ordered_hash'

class Sprites
  class SpritePieces
    include Enumerable

    SUPPORTED_OPTIONS = %w(x y)

    attr_accessor *SUPPORTED_OPTIONS

    def initialize(sprites, sprite)
      @sprites, @sprite = sprites, sprite
      @sprite_pieces = ActiveSupport::OrderedHash.new do |sprite_pieces, path|
        sprite_pieces[path] = SpritePiece.new(sprites, sprite, path)
      end
    end

    def add(path, css_selector, options = {})
      options.symbolize_keys!.assert_valid_keys(*(SUPPORTED_OPTIONS.map(&:intern)))

      @sprite_pieces[path].css_selector = css_selector

      options.each {|k,v| @sprite_pieces[path].send(:"#{k}=", v) }
      self
    end

    def each(*args, &blk)
      all.each(*args, &blk)
    end

    def empty?
      @sprite_pieces.empty?
    end

    def all
      @sprite_pieces.values
    end

    def [](val)
      @sprite_pieces.has_key?(val) ?
        @sprite_pieces[val] :
        nil
    end

    def element_at(index)
      @sprite_pieces.values[index]
    end

    def css
      @sprite_pieces.values.map {|sp| sp.css}.join("\n")
    end
  end
end
