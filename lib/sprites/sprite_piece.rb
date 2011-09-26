module Sprites
  class SpritePiece
    attr_reader :path
    attr_accessor :css_selector
    alias_method :selector, :css_selector

    def initialize(path)
      @path = path
    end
  end
end
