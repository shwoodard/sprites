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
      sprite_piece.left = 0
      sprite_piece.top = 345
      sprite_piece.width = 40
      sprite_piece.height = 50

      sprite_piece.css(config, sprite).should == <<-CSS
.foo
{
  display:block;
  width:40px;
  height:50px;
  background:url('/tmp/images/sprites/foo.png') no-repeat 0 -345px;
}
      CSS
    end
  end

  context 'when overriding the default x and y background-position settings' do
    it 'should allow you to override the x setting' do
      config = Configuration.new
      config.sprites_path('tmp/images/sprites')
      config.sprite_stylesheets_path('tmp/stylesheets/sprites')
      config.sprite_pieces_path('spec/fixtures/project1/public/images/sprite_images')
      
      sprite = Sprite.new(:foo).define do
        sprite_piece 'foo/bar.png' => '.foo', :x => 'right'
      end
      sprite_piece = sprite.sprite_pieces['foo/bar.png']

      generator = ChunkyPngGenerator.new(config)
      sprites = Sprites::Sprites.new
      sprites.add(sprite)

      generator.generate(sprites)

      sprite_piece.x.should == 'right'
      sprite_piece.css(config, sprite).should include('right')
    end
  end
end
