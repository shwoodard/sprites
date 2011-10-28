module Sprites
  class Configuration
    FIELDS = %w{backend sprites_path sprite_stylesheets_path sprite_pieces_path}

    DEFAULT_CONFIGURATION = {
      'backend' => :rmagick,
      'sprites_path' => 'public/images/sprites',
      'sprite_stylesheets_path' => 'public/stylesheets/sprites',
      'sprite_pieces_path' => 'public/images/sprite_images'
    }

    def initialize
      DEFAULT_CONFIGURATION.each {|k,v| self.send(k, v)}
    end

    def configure(&blk)
      instance_eval(&blk)
      self
    end

    def configured?
      FIELDS.any? do |field|
        send(field) != DEFAULT_CONFIGURATION[field]
      end
    end

    FIELDS.each do |meth|
      eval <<-EVAL
        def #{meth}(*args)
          val, *_ = args

          if val
            @#{meth} = val
            return self
          end

          @#{meth}
        end
      EVAL
    end

    alias_method :backend_without_override, :backend
    def backend_with_override(*args)
      val, *_ = args

      if val
        backend_without_override(val)
        return self
      end

      backend_without_override && backend_without_override.to_sym
    end
    alias_method :backend, :backend_with_override

    def self.new_for_command_line_options(options)
      config = new
      options.each do |k, v|
        if FIELDS.include?(k.to_s)
          config.send(k, v)
        end
      end
      config
    end
  end
end
