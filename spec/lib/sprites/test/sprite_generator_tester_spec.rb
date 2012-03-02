require 'spec_helper'
require 'sprites/test/sprite_generator_tester'

describe Sprites::SpriteGeneratorTester do
  let(:sprites) { Sprites.new }

  before do
    sprites.configuration.configure(
      :sprites_path => 'spec/fixtures/known_good/sprites',
      :sprite_pieces_path => 'spec/fixtures/known_good/sprite_images'
    )
   define_buttons_sprite
  end

  describe "#accurate" do
    it 'should return 0 for known good sprite' do
      sprites.configuration.configure(
        :sprite_stylesheets_path => 'spec/fixtures/known_good/stylesheets'
      )
      tester = Sprites::SpriteGeneratorTester.new(sprites[:buttons])
      tester.should be_accurate
    end
  end

  describe "#background_property_urls" do
    it "should match" do
      sprites.configuration.configure(
        :sprite_asset_path => '/assets/sprites',
        :sprite_stylesheets_path => 'tmp/stylesheets/sprites'
      )

      sprite_generator = Sprites::ChunkyPngGenerator.new(sprites)
      sprite_generator.generate

      sprite = sprites[:buttons]
      tester = Sprites::SpriteGeneratorTester.new(sprite)

      expected = []
      sprite.all_sprite_pieces.size.times { expected << "/assets/sprites/buttons.png" }

      tester.background_property_urls.should == expected
    end
  end
end
