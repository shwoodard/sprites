class Sprites
  class Railtie < ::Rails::Railtie

    def self.each_sprited_engine
      (Rails.application.railties.engines + [Rails.application]).each do |engine|
        next unless engine.config.respond_to?(:uses_sprites) && engine.config.uses_sprites
        yield engine
      end
    end

    rake_tasks do
      desc "Generate sprites and stylesheets"
      task :sprites => :environment do
        Sprites::Railtie.each_sprited_engine do |engine|
          sprite_generator = Sprites::ChunkyPngGenerator.new(engine.config.sprites)
          sprite_generator.generate
        end
      end
    end

    initializer 'sprites._rails-configuration' do
      Sprites::Railtie.each_sprited_engine do |engine|
        assets_path = "app/assets"

        engine.config.sprites = Sprites.new
        engine.config.sprites.configuration.configure(
          :sprites_path => engine.root.join(assets_path, 'images/sprites'),
          :sprite_stylesheets_path => engine.root.join(assets_path, 'stylesheets/sprites'),
          :sprite_pieces_path => engine.root.join(assets_path, 'images/sprite_images')
        )

        default_definition_file = File.join(engine.config.root, 'config/sprites.rb')
        if File.exists? default_definition_file        
          engine.config.sprites.configuration.definition_file = default_definition_file
        else
          engine.config.sprites.configuration.autoload = true
        end
      end
    end
  end
end
