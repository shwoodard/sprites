require 'spec_helper'

describe Sprites do
  before do
    @sprites = Sprites::Sprites.new
  end

  context 'initialize' do
    it 'should create the @sprites Hash' do
      @sprites.instance_variable_get(:@sprites).should be_a(Hash)
    end
  end

  context 'add' do
    context 'with the sprite identified by a symbol' do
      it 'should add a sprite to the collection' do
        @sprites.add(:foo) {}
        @sprites[:foo].should be_a(Sprite)
      end
    end

    context 'with the sprite identified by a string--the path to the sprite image' do
      it 'should add a sprite to the collection' do
        @sprites.add('images/sprites/foo.png') {}
        @sprites[:foo].should be_a(Sprite)
      end
    end

    context 'with the sprite identified by a hash--the mapping between the sprite image file and its stylesheet' do
      it 'should add a sprite to the collection' do
        @sprites.add('images/sprites/foo.png' => 'stylesheets/sprites/foo.css') {}
        @sprites[:foo].should be_a(Sprite)
      end
    end
  end
end
