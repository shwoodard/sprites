require 'sprites/sprites'

module Sprites

  # This class provides top level access to the Sprites application.
  # So far, three methods are available:
  # 1. define (_define_)
  # 2. sprite (_sprite_)
  #
  # Author:: Sam Woodard
  #
  # :title:Application

  class Application
    attr_reader :sprites

    # The +new+ class method initializes the class.
    # === Example
    #  sprites = Sprites.new
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
