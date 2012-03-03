require 'spec_helper'
require 'sprites/sprite_piece'

describe Sprites::SpritePiece do
  
  let(:sprites) { Sprites.new }
  
  context '#source_path' do
    it 'should return the full sprite piece path' do
      sprites.configuration.sprite_pieces_path = 'tmp/images/sprite_images'
      
      sprites.sprite(:foo).configure do
        sprite_piece 'foo/bar.png'
      end

      sprites[:foo].sprite_pieces.first.source_path.should == 'tmp/images/sprite_images/foo/bar.png'
    end
  end

  context '#css' do
    it 'should return the css for the sprite piece' do
      sprites.configuration.sprites_path = 'tmp/images/sprites'
      
      sprites.sprite(:foo).configure do
        sprite_piece 'foo/bar.png', '.foo'
      end

      sprite_piece = sprites[:foo].sprite_pieces['foo/bar.png']
      sprite_piece.left = 0
      sprite_piece.top = 345
      sprite_piece.width = 40
      sprite_piece.height = 50

      sprite_piece.css.should == <<-CSS
.foo
{
  display:block;
  width:40px;
  height:50px;
  background:url('/images/sprites/foo.png') no-repeat 0 -345px;
}
      CSS
    end
  end

  context 'when overriding the default x and y background-position settings' do
    it 'should allow you to override the x setting' do
      sprites.configuration.sprites_path ='tmp/images/sprites'
      sprites.configuration.sprite_stylesheets_path = 'tmp/stylesheets/sprites'
      sprites.configuration.sprite_pieces_path = 'spec/fixtures/project1/public/images/sprite_images'
      
      sprites.sprite(:foo).configure do
        sprite_piece 'foo/bar.png', '.foo', :x => 'right'
      end
      sprite_piece = sprites[:foo].sprite_pieces['foo/bar.png']

      generator = Sprites::ChunkyPngGenerator.new(sprites)

      generator.generate

      sprite_piece.x.should == 'right'
      sprite_piece.css.should include('right')
    end
  end
end
