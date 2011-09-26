require 'active_support/ordered_hash'

module Sprites
  class SpritePieces
    def initialize
      @sprite_pieces = ActiveSupport::OrderedHash.new do |sprite_pieces, path|
        sprite_pieces[path] = SpritePiece.new(path)
      end
    end

    def count
      @sprite_pieces.size
    end

    def empty?
      @sprite_pieces.empty?
    end

    def [](val)
      @sprite_pieces[val]
    end

    def add(options)
      path, css_selector = options.find {|k,v| k.is_a?(String)}
      @sprite_pieces[path].css_selector = css_selector
      @sprite_pieces[path]
    end
  end
end