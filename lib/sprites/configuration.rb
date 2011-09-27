module Sprites
  class Configuration
    FIELDS = %w{backend images_path stylesheets_path sprites_path sprite_stylesheets_path sprite_pieces_path}
    DEFAULT_CONFIGURATIONS = {
      'backend' => :rmagick,
      'images_path' => 'images',
      'stylesheets_path' => 'stylesheets'
    }

    DEFAULT_RELATIVE_PATHS = {
      'sprites_path' => 'images/sprites',
      'sprite_stylesheets_path' => 'stylesheets/sprites',
      'sprite_pieces_path' => 'images/sprite_images'
    }

    def initialize
      DEFAULT_CONFIGURATIONS.each {|k,v| self.send(k, v)}
    end

    def configure(&blk)
      instance_eval(&blk)
      self
    end

    FIELDS.each do |meth|
      eval <<-EVAL
        def #{meth}(*args)
          val, _ = *args

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
      val, _ = *args

      if val
        backend_without_override(val)
        return self
      end

      backend_without_override.to_sym
    end
    alias_method :backend, :backend_with_override

    FIELDS.reject {|f| DEFAULT_CONFIGURATIONS.keys.include?(f) }.each do |meth|
      eval <<-EVAL
        alias_method :#{meth}_without_default, :#{meth}
        def #{meth}_with_default(*args)
          val, _ = *args

          if val
            #{meth}_without_default(val)
            return self
          end

          @#{meth} || '#{DEFAULT_RELATIVE_PATHS[meth]}'
        end
        alias_method :#{meth}, :#{meth}_with_default
      EVAL
    end
  end
end
