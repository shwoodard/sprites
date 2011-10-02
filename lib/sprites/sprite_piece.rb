module Sprites
  class SpritePiece
    attr_reader :path
    attr_accessor :css_selector, :info
    alias_method :selector, :css_selector

    Info = Struct.new(:x, :y, :width, :height)

    def initialize(path)
      @path = path
    end

    def self.sprite_piece_full_path(configuration, sprite_piece)
      File.join(configuration.sprite_pieces_path, sprite_piece.path)
    end
  end
end
