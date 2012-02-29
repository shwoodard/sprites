require 'spec_helper'
require 'sprites/sprite'

describe Sprites::Sprite do
  let(:sprites) { Sprites.new }

  before do
    @sprite = sprites.sprite(:foo)
  end

  after do
    sprites.reset!
  end

  context '#name' do
    it 'should retrieve the name' do
      @sprite.name.should == :foo
    end
  end

  context '#path' do
    it 'should retrieve the path' do
      @sprite.path.should == "public/images/sprites/foo.png"
    end
  end

  context "#sprite_piece" do
    it 'should respond_to sprite_piece' do
      Sprites::Sprite.new(:foo, sprites).should respond_to(:sprite_piece)
    end

    it 'should return a Sprites::SpritePieces' do
      sprite = Sprites::Sprite.new(:foo, sprites)
      sprite.sprite_piece('sprite_images/foo.png', '.foo').should be_a(Sprites::SpritePieces)
    end

    it 'should add a sprite piece to the collection' do
      sprite = Sprites::Sprite.new(:foo, sprites)
      sprite.sprite_piece('sprite_images/foo.png', '.foo')
      sprite.sprite_pieces.should_not be_empty
      sprite.sprite_pieces.count.should be(1)
      sprite.sprite_pieces['sprite_images/foo.png'].selector.should == '.foo'
    end
  end

  context '#sprite_pieces' do
    it 'should return a SpritePieces adt' do
      @sprite.sprite_pieces.should be_a(Sprites::SpritePieces)
    end
  end

  context '#stylesheet_path' do
    it 'should return the stylesheet path' do
      @sprite.stylesheet_path.should == 'public/stylesheets/sprites/foo.css'
    end
  end

  context '#orientation=' do
    it 'should set the orientation' do
      @sprite.orientation = Sprites::Sprite::Orientations::HORIZONTAL
      @sprite.orientation.should be(Sprites::Sprite::Orientations::HORIZONTAL)
    end
  end

  context '#orientation' do
    it 'should return the default orientation' do
      @sprite.orientation.should be(Sprites::Sprite::Orientations::VERTICAL)
    end
  end

  context '#background_property_url' do
    it 'should return the path for use in the url in the background style attribute' do
      sprites.configuration.configure(:sprite_asset_path => '/assets/sprites')
      sprite = Sprites::Sprite.new(:foo, sprites)

      sprite.background_property_url.should == '/assets/sprites/foo.png'
    end
  end
end
