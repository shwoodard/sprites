require 'rails/railtie'
require 'sprites'

module Sprites
  class Railtie < Rails::Railtie
    rake_tasks do
      desc "Generate sprites and stylesheets"
      task :sprites => :environment do
        assets_root = Rails.application.config.assets[:enabled] ? 'app/assets' : 'public'

        ::Sprites.configure do
          sprites_path Rails.root.join(assets_root, 'images/sprites')
          sprite_stylesheets_path Rails.root.join(assets_root, 'stylesheets/sprites')
          sprite_pieces_path Rails.root.join(assets_root, 'images/sprite_images')
        end unless ::Sprites.configuration.configured?

        unless (def_file_path = Rails.root.join('config/sprites.rb')).exist?
          raise CliApplication::DefinitionFileNotFound
        end

        load def_file_path
        sprite_generator = ChunkyPngGenerator.new(::Sprites.configuration)
        sprite_generator.generate(::Sprites.application.sprites)
      end
    end
  end
end
