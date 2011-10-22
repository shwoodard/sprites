require 'spec_helper'
require 'sprites/sprite_generator'
require 'sprites/test/sprite_generator_tester'

describe MiniMagickGenerator do
  it 'should generate a sprite and a stylesheet' do
    pending "Need to fix ImageMagick generator so that it matches the component images"
    Sprites.configure do
      sprites_path 'tmp/images/sprites/foo3'
      sprite_stylesheets_path 'tmp/images/stylesheets/foo3'
      sprite_pieces_path File.join(Sprites.gem_root, 'spec/fixtures/known_good/sprite_images')
    end

    define_buttons_sprite
    sprite_generator = MiniMagickGenerator.new(Sprites.configuration)
    sprite_generator.generate(Sprites.application.sprites)

    tester = SpriteGeneratorTester.new(Sprites.application.sprites[:buttons], Sprites.configuration)
    tester.should be_accurate
  end
end
