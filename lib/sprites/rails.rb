require 'sprites'
require 'rails/railtie'

class Sprites  
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load File.expand_path('../rails/sprites.rake', __FILE__)
    end

    initializer 'sprites._rails-configuration' do
      assets_root = Rails.application.config.assets[:enabled] ? 'app/assets' : 'public'

      ::Sprites.configure do
        config.sprites_path = Rails.root.join(assets_root, 'images/sprites')
        config.sprite_stylesheets_path = Rails.root.join(assets_root, 'stylesheets/sprites')
        config.sprite_pieces_path = Rails.root.join(assets_root, 'images/sprite_images')
      end unless ::Sprites.configuration.configured?
    end
  end
end
