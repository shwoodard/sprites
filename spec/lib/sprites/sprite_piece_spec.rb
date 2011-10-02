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
end
