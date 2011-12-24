require 'spec_helper'
require 'sprites/test/sprite_generator_tester'

describe SpriteGeneratorTester do
  describe "#test_generator" do
    it 'should return 0 for known good sprite' do
      Sprites.configure do
        config.sprites_path = 'spec/fixtures/known_good/sprites'
        config.sprite_stylesheets_path = 'spec/fixtures/known_good/stylesheets'
        config.sprite_pieces_path = 'spec/fixtures/known_good/sprite_images'
      end
      define_buttons_sprite
      tester = SpriteGeneratorTester.new(Sprites.application.sprites[:buttons], Sprites.configuration)
      tester.should be_accurate
    end
  end
end
