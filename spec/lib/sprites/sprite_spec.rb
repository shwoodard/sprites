require 'spec_helper'
require 'sprites/sprite'

describe Sprite do
  before do
    @sprite = Sprite.new(:foo)
  end

  context '#name' do
    it 'should retrieve the name' do
      @sprite.name.should == :foo
    end
  end

  context '#path' do
    it 'should retrieve the path' do
      @sprite.define(:foo) {}
      @sprite.path.to_s.should == "sprites/foo.png"
    end
  end

  context "#define", "a method to further initialize the Sprite, e.g. with spite pieces" do
    shared_examples "a sprite definition with no options" do
      it 'the options should be a hash' do
        @sprite.instance_variable_get(:@options).should be_a(Hash)
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

  context '#sprite_pieces' do
    it 'should return a SpritePieces adt' do
      @sprite.sprite_pieces.should be_a(SpritePieces)
    end
  end

  context '#stylesheet' do
    it 'should return a Stylesheet' do
      @sprite.define(:foo) {}
      @sprite.stylesheet.should be_a(Stylesheet)
    end
  end

  context '#stylesheet_path' do
    it 'should return the stylesheet path' do
      @sprite.define(:foo) {}
      @sprite.stylesheet_path.to_s.should == 'sprites/foo.css'
    end
  end

  context '#orientation' do
    it 'should set the orientation' do
      @sprite.orientation(Sprite::Orientations::HORIZONTAL)
      @sprite.orientation.should be(Sprite::Orientations::HORIZONTAL)
    end

    it 'should set and return the default orientation' do
      @sprite.orientation.should be(Sprite::Orientations::VERTICAL)
    end
  end

  context "self.sprite_full_path(configuration, sprite)" do
    config = Configuration.new
    config.images_path('tmp/images')

    sprite = Sprite.new(:foo)

    Sprite.sprite_full_path(config, sprite).should == 'tmp/images/sprites/foo.png'
  end
end
