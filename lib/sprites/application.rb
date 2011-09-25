require 'sprites/sprites'

module Sprites
  class Application
    attr_reader :sprites

    def initialize
      @sprites = Sprites.new
    end

    def define(&blk)
      instance_eval(&blk)
    end

    def sprite(*args, &blk)
      sprites.add(*args, &blk)
    end
  end
end
