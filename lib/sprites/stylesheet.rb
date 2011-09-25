module Sprites
  class Stylesheet
    attr_reader :path
    alias_method :stylesheet_path, :path

    def initialize(path)
      @path = path
    end
  end
end
