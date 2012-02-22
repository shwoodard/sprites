require 'spec_helper'
require 'sprites/sprite_pieces'

describe Sprites::SpritePieces do

  before do
    @sprite_pieces = Sprites::SpritePieces.new

    sprite_pieces = [
      ['foo.png', 'foo.css'],
      ['bar.png', 'bar.css'],
      ['bas.png', 'bas.css']
    ]

    @sprite_piece_definitions = sprite_pieces.map(&:clone)

    sprite_pieces.each do |sp|
      @sprite_pieces.add(*sp)
    end
  end

  context '#map' do
    it 'should allow access to the @sprite_pieces OrderedHash values and allow them to be mapped' do
      @sprite_pieces.map {|sp| [sp.path, sp.selector] }.should == @sprite_piece_definitions
    end
  end

  context '#element_at' do
    it 'should return the element at the given index' do
      @sprite_pieces.element_at(1).path.should == 'bar.png'
      @sprite_pieces.element_at(1).selector.should == 'bar.css'
    end
  end
end
