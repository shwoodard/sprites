require 'pathname'
require 'optparse'

class Sprites
  class CommandLineOptionParser < OptionParser
    attr_reader :definition_file_path, :options

    def initialize(arguments)
      @arguments, @raw_arguments = arguments.clone, arguments
      @definition_file_path = extract_sprite_definition_file_path(@arguments)
      @options = Hash.new

      super do |opts|
        setup_parser(opts)
      end
    end

    def parse
      super(@raw_arguments)
    end

    def extract_sprite_definition_file_path(arguments)
      sprite_def_file_pathname = if arguments[0] =~ %r{^.+\.rb}
        Pathname(arguments.shift)
      elsif File.exists?(path = File.join(Dir.pwd, 'config/sprites.rb').tap{|x| p x})
        Pathname(path)
      else
        raise CliApplication::DefinitionFileNotFound
      end

      sprite_def_file_pathname.realpath.to_s
    end

    def setup_parser(opts)
      opts.banner = "Usage: sprites [defintion_file] [options]"

      opts.separator ""
      opts.separator "Specific options:"

      opts.on("-r", "--project_root", <<-EOS
Define the path to the root of the project. DEFAULT: pwd
      EOS
      ) do |path|
        @options[:project_root] = path || Dir.pwd
      end

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
