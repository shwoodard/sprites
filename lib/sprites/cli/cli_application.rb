class Sprites
  class CliApplication
    class DefinitionFileNotFound < StandardError; end

    def self.run(def_file, configuration)
      sprites = Sprites.new
      sprites.configure(configuration.to_options)
      sprites.load
      sprite_generator = ChunkyPngGenerator.new(sprites)
      sprite_generator.generate
    end
  end
end
