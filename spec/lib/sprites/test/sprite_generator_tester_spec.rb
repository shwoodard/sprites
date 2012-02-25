require 'spec_helper'
require 'sprites/test/sprite_generator_tester'

describe Sprites::SpriteGeneratorTester do
  describe "#test_generator" do
    let(:sprites) { Sprites.new }

    it 'should return 0 for known good sprite' do
      sprites.configuration.configure(
        :sprites_path => 'spec/fixtures/known_good/sprites',
        :sprite_stylesheets_path => 'spec/fixtures/known_good/stylesheets',
        :sprite_pieces_path => 'spec/fixtures/known_good/sprite_images'
      )
      define_buttons_sprite
      tester = Sprites::SpriteGeneratorTester.new(sprites[:buttons], sprites.configuration)
      tester.should be_accurate
    end
  end
end
