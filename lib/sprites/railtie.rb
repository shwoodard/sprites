class Sprites
  class Railtie < ::Rails::Railtie
    rake_tasks do
      desc "Generate sprites and stylesheets"
      task :sprites => :environment do
        unless (def_file_path = Rails.root.join('config/sprites.rb')).exist?
          raise Sprites::CliApplication::DefinitionFileNotFound
        end

        require def_file_path
        sprite_generator = Sprites::ChunkyPngGenerator.new(Sprites.configuration)
        sprite_generator.generate(Sprites.application.sprites)
      end
    end

    initializer 'sprites._rails-configuration' do
      assets_root = Rails.application.config.assets[:enabled] ? 'app/assets' : 'public'

      Sprites.configure do
        config.sprites_path = Rails.root.join(assets_root, 'images/sprites')
        config.sprite_stylesheets_path = Rails.root.join(assets_root, 'stylesheets/sprites')
        config.sprite_pieces_path = Rails.root.join(assets_root, 'images/sprite_images')
      end
    end

    initializer 'sprites.autoload' do
      Dir[File.join(Sprites.configuration.sprite_pieces_path, '*')].each do |sprite_path|
        sprite = Sprites::Sprite.new(File.basename(sprite_path).intern).configure
        Sprites.application.sprites.add(sprite) if File.directory?(sprite_path)
      end
    end
  end
end
