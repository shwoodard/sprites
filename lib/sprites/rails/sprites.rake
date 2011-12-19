require 'sprites'

include Rake::DSL if defined?(Rake::DSL)
include Sprites

desc "Generate sprites and stylesheets"
task :sprites => :environment do
  unless (def_file_path = Rails.root.join('config/sprites.rb')).exist?
    raise CliApplication::DefinitionFileNotFound
  end

  load def_file_path
  sprite_generator = ChunkyPngGenerator.new(::Sprites.configuration)
  sprite_generator.generate(::Sprites.application.sprites)
end
