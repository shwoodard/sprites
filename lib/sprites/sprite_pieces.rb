require 'active_support/ordered_hash'

module Sprites
  class SpritePieces
    include Enumerable

    def initialize
      @sprite_pieces = ActiveSupport::OrderedHash.new do |sprite_pieces, path|
        sprite_pieces[path] = SpritePiece.new(path)
      end
    end

    def add(path, css_selector, options = {})
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

    def css(configuration = ::Sprites.configuration, sprite = @sprite)
      @sprite_pieces.values.map {|sp| sp.css(configuration, sprite)}.join("\n")
    end
  end
end