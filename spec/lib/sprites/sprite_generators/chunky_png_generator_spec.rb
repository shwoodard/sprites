require 'spec_helper'
require 'sprites/test/sprite_generator_tester'

describe Sprites::ChunkyPngGenerator do
  it 'should generate a sprite and a stylesheet' do
    Sprites.configure do
      config.sprites_path = 'tmp/images/sprites/foo2/sprites'
      config.sprite_stylesheets_path = 'tmp/images/stylesheets/foo2/sprites'
      config.sprite_pieces_path = File.join(GEM_ROOT, 'spec/fixtures/known_good/sprite_images')
    end

    define_buttons_sprite

    sprite_generator = Sprites::ChunkyPngGenerator.new(Sprites.configuration)
    sprite_generator.generate(Sprites.application.sprites)

    tester = Sprites::SpriteGeneratorTester.new(Sprites.application.sprites[:buttons], Sprites.configuration)
    tester.should be_accurate
  end
end
