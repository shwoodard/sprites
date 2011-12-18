require 'spec_helper'
require 'sprites/test/sprite_generator_tester'

describe ChunkyPngGenerator do
  it 'should generate a sprite and a stylesheet' do
    Sprites.configure do
      sprites_path 'tmp/images/sprites/foo2/sprites'
      sprite_stylesheets_path 'tmp/images/stylesheets/foo2/sprites'
      sprite_pieces_path File.join(Sprites.gem_root, 'spec/fixtures/known_good/sprite_images')
    end

    define_buttons_sprite

    sprite_generator = ChunkyPngGenerator.new(Sprites.configuration)
    sprite_generator.generate(Sprites.application.sprites)

    tester = SpriteGeneratorTester.new(Sprites.application.sprites[:buttons], Sprites.configuration)
    tester.should be_accurate
  end
end
