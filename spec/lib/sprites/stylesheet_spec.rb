require 'spec_helper'

describe Stylesheet do

  context "self.sprite_full_path(configuration, sprite)" do
    it 'should return the stylesheet full path' do
      config = Configuration.new
      config.sprite_stylesheets_path('tmp/stylesheets')
      sprite = Sprite.new(:foo)
      stylesheet = Stylesheet.new('sprites/foo.css', sprite)

      Stylesheet.stylesheet_full_path(config, stylesheet).should == 'tmp/stylesheets/sprites/foo.css'
    end
  end

  context '#sprite_pieces, #sprite_pieces=' do
    it 'should allow access to and setting of sprite_pieces' do
      sprite = Sprite.new(:foo)
      stylesheet = Stylesheet.new('foo/bar.css', sprite)
      sprite_pieces = SpritePieces.new
      stylesheet.sprite_pieces = sprite_pieces
      stylesheet.sprite_pieces.should be(sprite_pieces)
    end
  end
end
