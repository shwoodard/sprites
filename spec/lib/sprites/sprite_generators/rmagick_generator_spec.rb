require 'spec_helper'
require 'sprites/sprite_generators/rmagick_generator'

describe RMagickGenerator do
  it 'should generate a sprite and a stylesheet' do
    pending "Need to fix RMagick generator so that it matches the component images"
    Sprites.configure do
      sprites_path 'tmp/images/sprites/foo1'
      sprite_stylesheets_path 'tmp/images/stylesheets/foo1'
      sprite_pieces_path File.join(Sprites.gem_root, 'spec/images/known_good/sprite_images')
    end

    define_buttons_sprite
    sprite_generator = RMagickGenerator.new(Sprites.configuration)
    sprite_generator.generate(Sprites.application.sprites)

    tester = SpriteGeneratorTester.new(Sprites.application.sprites[:buttons], Sprites.configuration)
    tester.should be_accurate
  end
end
