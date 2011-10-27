require 'pathname'

module Sprites
  class CommandLineOptionParser < OptionParser
    PRIMARY_DEF_FILE_LOCATION = 'config/sprites.rb'
    SECONDARY_DEF_FILE_LOCATION = 'sprites.rb'

    attr_reader :definition_file_path, :options

    def initialize(arguments)
      @definition_file_path, @arguments = extract_sprite_definition_file_path(arguments.clone)
      @options = Hash.new

      super do |opts|
        setup_parser(opts)
      end
    end

    def parse
      super(@arguments)
    end

    def extract_sprite_definition_file_path(arguments)
      sprite_def_file_pathname = if arguments[0] =~ %r{^.+\.rb}
        Pathname(arguments.shift)
      elsif file_exists?('config/sprites.rb')
        Pathname('config/sprites.rb')
      else
        raise
      end

      [sprite_def_file_pathname.realpath.to_s, arguments]
    rescue
      raise CliApplication::DefinitionFileNotFound
    end

    def file_exists?(path)
      Pathname(path).exist?
    end

    def setup_parser(opts)
      opts.banner = "Usage: sprites [defintion_file] [options]"

      opts.separator ""
      opts.separator "Specific options:"

      opts.on("-s", "--sprites_path", <<-EOS
Define the path to where the sprites should be placed. DEFAULT: 'public/images/sprites'
      EOS
      ) do |path|
        @options[:sprites_path] = path
      end

      opts.on("-c", "--sprite_stylesheets_path", <<-EOS
Define the path to where the sprites stylesheets should be placed. DEFAULT: 'public/stylesheets/sprites'
      EOS
      ) do |path|
        @options[:sprite_stylesheets_path] = path
      end

      opts.on("-p", "--sprite_pieces_path", <<-EOS
Define the path to where the images needed to build the sprites are stored. DEFAULT: 'public/images/sprite_pieces'
      EOS
      ) do |path|
        @options[:sprite_pieces_path] = path
      end
    end
  end
end
