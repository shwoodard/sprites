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
    def initialize(configuration = ::Sprites.configuration)
      @configuration = configuration
      @sprites = Sprites.new
    end

    # The +define+ method provides access to the dsl
    # === Example
    # Sprites.application.define do
    #   ...
    # end
    def define(&blk)
      instance_eval(&blk)
    end


    # The +sprite+ method adds sprites to the application
    # === Example
    # Sprites.application.define do
    #   ...
    # end
    def sprite(*args, &blk)
      sprites.add(*args, &blk)
    end
  end
end
