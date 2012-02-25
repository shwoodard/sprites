class Sprites
  class Configuration
    FIELDS = %w{definition_file autoload sprite_asset_path sprites_path sprite_stylesheets_path sprite_pieces_path}

    DEFAULT_CONFIGURATION = {
      'sprites_path' => 'public/images/sprites',
      'sprite_stylesheets_path' => 'public/stylesheets/sprites',
      'sprite_pieces_path' => 'public/images/sprite_images',
      'sprite_asset_path' => 'images/sprites',
      'autoload' => true
    }

    attr_accessor *FIELDS

    def initialize
      DEFAULT_CONFIGURATION.each {|k,v| self.send(:"#{k}=", v)}
    end

    def configure(options)
      options.each {|k,v| self.send(:"#{k}=", v)}
    end

    def config
      self
    end

    def configured?
      FIELDS.any? do |field|
        send(field) != DEFAULT_CONFIGURATION[field]
      end
    end

    def self.new_for_command_line_options(options)
      config = new
      options.each do |k, v|
        if FIELDS.include?(k.to_s)
          config.send(:"#{k}=", v)
        end
      end
      config
    end
  end
end
