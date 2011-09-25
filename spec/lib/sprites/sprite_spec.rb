require 'spec_helper'
require 'sprites/sprite'

describe Sprite do
  context "#sprite_piece" do
    it 'should respond_to sprite_piece' do
      Sprite.new(:foo).should respond_to(:sprite_piece)
    end

    it 'should return a Sprites::SpritePiece' do
      sprite = Sprite.new(:foo)
      sprite.sprite_piece('sprite_images/foo.png' => '.foo').should be_a(SpritePiece)
    end

    it 'should add a sprite piece to the collection' do
      sprite = Sprite.new(:foo)
      sprite.sprite_piece('sprite_images/foo.png' => '.foo')
      sprite.sprite_pieces.should_not be_empty
      sprite.sprite_pieces.count.should be(1)
      sprite.sprite_pieces['sprite_images/foo.png'].selector.should == '.foo'
    end
  end
end
