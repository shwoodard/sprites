module Sprites
  class Stylesheet
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def self.stylesheet_full_path(configuration, stylesheet)
      File.join(configuration.sprite_stylesheets_path, stylesheet.path)
    end
  end
end
