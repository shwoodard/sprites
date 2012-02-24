require 'spec_helper'
require 'sprites/test/sprite_generator_tester'

describe Sprites::ChunkyPngGenerator do
  let(:sprites) { Sprites.new }
  it 'should generate a sprite and a stylesheet' do
    sprites.configuration.configure(
      :sprites_path => 'tmp/images/sprites/foo2/sprites',
      :sprite_stylesheets_path => 'tmp/images/stylesheets/foo2/sprites',
      :sprite_pieces_path => File.join(GEM_ROOT, 'spec/fixtures/known_good/sprite_images')
    )

    define_buttons_sprite

    sprite_generator = Sprites::ChunkyPngGenerator.new(sprites)
    sprite_generator.generate

    tester = Sprites::SpriteGeneratorTester.new(sprites[:buttons], sprites.configuration)
    tester.should be_accurate
  end
end
