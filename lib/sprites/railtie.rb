class Sprites
  class Railtie < ::Rails::Railtie

    def self.each_sprited_engine
      (Rails.application.railties.engines + [Rails.application]).each do |engine|
        next unless engine.config.respond_to?(:uses_sprites) && engine.config.uses_sprites
        yield engine
      end
    end

    def self.cattr_accessor_name(engine_name)
      :"sprites_for_#{engine_name}"
    end

    rake_tasks do
      desc "Generate sprites and stylesheets"
      task :sprites => :environment do
        Sprites::Railtie.each_sprited_engine do |engine|
          next if engine.class.superclass == Rails::Engine && !ENV['ENGINES']

          sprites = engine.class.send(Sprites::Railtie.cattr_accessor_name(engine.engine_name))

          sprite_generator = Sprites::ChunkyPngGenerator.new(sprites)
          sprite_generator.generate
        end
      end
    end

    initializer 'sprites._rails-configuration' do
      Sprites::Railtie.each_sprited_engine do |engine|
        assets_path = "app/assets"

        sprites = Sprites.new

        engine.class.cattr_accessor(Sprites::Railtie.cattr_accessor_name(engine.engine_name)) { sprites }
        sprites.configuration.configure(
          :sprites_path => engine.root.join(assets_path, 'images/sprites'),
          :sprite_stylesheets_path => engine.root.join(assets_path, 'stylesheets/sprites'),
          :sprite_pieces_path => engine.root.join(assets_path, 'images/sprite_images'),
          :sprite_asset_path => '/assets/sprites'
        )

        default_definition_file = File.join(engine.config.root, 'config/sprites.rb')
        if File.exists? default_definition_file        
          sprites.configuration.definition_file = default_definition_file
        else
          sprites.configuration.autoload = true
        end
      end
    end
  end
end
