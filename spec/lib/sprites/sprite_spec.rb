require 'spec_helper'
require 'sprites/sprite'

describe Sprite do
  before do
    @sprite = Sprite.new(:foo)
  end

  context "#define", "a method to further initialize the Sprite, e.g. with spite pieces" do
    shared_examples "a sprite definition with no options" do
      it 'the options should be empty' do
        @sprite.instance_variable_get(:@options).should be_empty
      end

      it 'should set the path' do
        @sprite.path.should be_a(Pathname)
        @sprite.path.to_s.should == 'sprites/foo.png'
      end

      it 'should set the create the Stylesheet' do
        @sprite.stylesheet.should be_a(Stylesheet)
      end
    end

    context 'when defining with a symbol and no options' do
      before do
        @sprite.define(:foo) {}
      end

      it_behaves_like("a sprite definition with no options")
    end

    context 'when defining with hash but no extra options' do
      before do
        @sprite.define('sprites/foo.png' => 'stylesheets/sprites/foo.css') {}
      end

      it_behaves_like("a sprite definition with no options")
    end

    context 'when defining with a string and no options' do
      before do
        @sprite.define('sprites/foo.png') {}
      end

      it_behaves_like("a sprite definition with no options")
    end
    
  end

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
