class Sprites
  class CliApplication
    class DefinitionFileNotFound < StandardError; end

    def self.run(def_file, configuration)
      load def_file
      sprite_generator = ChunkyPngGenerator.new(configuration)
      sprite_generator.generate(Sprites.application.sprites)
    end
  end
end
