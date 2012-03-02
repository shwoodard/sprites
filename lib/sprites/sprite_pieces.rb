require 'active_support/ordered_hash'

class Sprites
  class SpritePieces
    include Enumerable

    def initialize(sprites, sprite)
      @sprites, @sprite = sprites, sprite
      @sprite_pieces = ActiveSupport::OrderedHash.new do |sprite_pieces, path|
        sprite_pieces[path] = SpritePiece.new(sprites, sprite, path)
      end
    end

    def add(path, css_selector, options = {})
      @sprite_pieces[path].css_selector = css_selector
      @sprite_pieces[path].configure(options)
      
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
      @sprite_pieces[val] if @sprite_pieces.has_key?(val)
    end

    def element_at(index)
      @sprite_pieces.values[index]
    end

    def css
      @sprite_pieces.values.map {|sp| sp.css}.join("\n")
    end
  end
end
