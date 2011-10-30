require 'active_support/ordered_hash'

module Sprites
  class SpritePieces
    def initialize
      @sprite_pieces = ActiveSupport::OrderedHash.new do |sprite_pieces, path|
        sprite_pieces[path] = SpritePiece.new(path)
      end
    end

    def add(options)
      path, css_selector = options.find {|k,v| k.is_a?(String)}
      @sprite_pieces[path].css_selector = css_selector
      options.delete(path)
      options.each {|k,v| @sprite_pieces[path].send(:"#{k}=", v) }
      @sprite_pieces[path]
    end

    def count
      @sprite_pieces.size
    end

    def all
      @sprite_pieces.values
    end

    def empty?
      @sprite_pieces.empty?
    end

    def [](val)
      @sprite_pieces.has_key?(val) ?
        @sprite_pieces[val] :
        nil
    end

    def element_at(index)
      @sprite_pieces.values[index]
    end

    def map(*args, &blk)
      @sprite_pieces.values.map(*args, &blk)
    end

    def find(*args, &blk)
      @sprite_pieces.values.find(*args, &blk)
    end

    def css(configuration = ::Sprites.configuration, sprite = @sprite)
      @sprite_pieces.values.map {|sp| sp.css(configuration, sprite)}.join("\n")
    end
  end
end