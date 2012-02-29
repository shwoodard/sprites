class Sprites
  class Configuration
    PATH_FIELDS = %w{definition_file sprites_path sprite_stylesheets_path sprite_pieces_path}
    OTHER_FIELDS = %w{definition_file autoload sprite_asset_path generator}
    FIELDS = PATH_FIELDS + OTHER_FIELDS

    DEFAULT_CONFIGURATION = {
      'sprites_path' => 'public/images/sprites',
      'sprite_stylesheets_path' => 'public/stylesheets/sprites',
      'sprite_pieces_path' => 'public/images/sprite_images',
      'sprite_asset_path' => '/images/sprites',
      'generator' => ChunkyPngGenerator,
      'autoload' => true
    }

    attr_accessor *FIELDS

    def initialize
      DEFAULT_CONFIGURATION.each {|k,v| self.send(:"#{k}=", v)}
    end

    def configure(options)
      # p options
      options.each {|k,v| self.send(:"#{k}=", v)}
    end

    def config
      self
    end

    def to_options
      options = Hash.new
      FIELDS.each {|option| options[option.intern] = send(option) }
      options
    end

    def configured?
      FIELDS.any? do |field|
        send(field) != DEFAULT_CONFIGURATION[field]
      end
    end

    def self.new_for_command_line_options(options)
      config = new

      options.each do |k, v|
        if options.has_key? :project_root
          if PATH_FIELDS.include?(k.to_s)
            config.send(:"#{path_field}=", File.join(options[:project_root], options[path_field.intern]))
          elsif OTHER_FIELDS.include?(k.to_s)
            config.send(:"#{k}=", v)
          end
        elsif FIELDS.include?(k.to_s)
          config.send(:"#{k}=", v)
        end
      end

      config
    end
  end
end
