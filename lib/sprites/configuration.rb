module Sprites
  class Configuration
    FIELDS = %w{backend}

    def configure(&blk)
      instance_eval(&blk)
      self
    end

    FIELDS.each do |meth|
      eval <<-EVAL
        def #{meth}(*args)
          val, _ = *args
          @#{meth} = val if val
          @#{meth}
        end
      EVAL
    end
  end
end
