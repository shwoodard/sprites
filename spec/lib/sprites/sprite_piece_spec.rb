require 'spec_helper'

describe SpritePiece do
  context 'self.sprite_piece_full_path' do
    it 'should return the full sprite piece path' do
      config = Configuration.new
      config.sprite_pieces_path('tmp/images/sprite_images')

      sprite_piece = SpritePiece.new('foo/bar.png')

      SpritePiece.sprite_piece_full_path(config, sprite_piece).should == 'tmp/images/sprite_images/foo/bar.png'
    end
  end

  context '#css' do
    it 'should return the css for the sprite piece' do
      config = Configuration.new
      config.sprites_path('tmp/images/sprites')
      
      sprite = Sprite.new(:foo).define do
        sprite_piece 'foo/bar.png' => '.foo'
      end

      sprite_piece = sprite.sprite_pieces['foo/bar.png']
      sprite_piece.x = 0
      sprite_piece.y = 345
      sprite_piece.width = 40
      sprite_piece.height = 50

      sprite_piece.css.should == <<-CSS
.foo
{
  display:block;
  width:40px;
  height:50px;
  background:url('/tmp/images/sprites/foo.png') no-repeat 0 -345px
}
      CSS
    end
  end
end
