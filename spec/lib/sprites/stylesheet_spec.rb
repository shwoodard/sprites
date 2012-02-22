require 'spec_helper'

describe Sprites::Stylesheet do

  context "self.sprite_full_path(configuration, sprite)" do
    it 'should return the stylesheet full path' do
      config = Sprites::Configuration.new
      config.sprite_stylesheets_path = 'tmp/stylesheets/sprites'
      sprite = Sprites::Sprite.new(:foo, config)
      stylesheet = Sprites::Stylesheet.new(sprite)
      Sprites::Stylesheet.stylesheet_full_path(config, stylesheet).should == 'tmp/stylesheets/sprites/foo.css'
    end
  end

  context '#sprite_pieces, #sprite_pieces=' do
    it 'should allow access to and setting of sprite_pieces' do
      sprite = Sprites::Sprite.new(:foo)
      stylesheet = Sprites::Stylesheet.new(sprite)
      sprite_pieces = Sprites::SpritePieces.new
      stylesheet.sprite_pieces = sprite_pieces
      stylesheet.sprite_pieces.should be(sprite_pieces)
    end
  end
end
