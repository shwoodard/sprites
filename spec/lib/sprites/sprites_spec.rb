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

  context '#add' do
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

    it 'should add the sprite if passed in a Sprites::Sprite' do
      sprite = Sprite.new(:"foo") {}
      @sprites.add(sprite)
      @sprites[:foo].should be(sprite)
    end
  end

  context '#clear' do
    it 'should clear the collection' do
      @sprites.add(:foo) {}
      @sprites.should_not be_empty
      @sprites.clear
      @sprites.should be_empty
    end
  end

  context '#[]' do
    it 'should retrieve the sprite' do
      @sprites[:foo].should be_nil
      @sprites.add(:foo) {}
      @sprites[:foo].should be_a(Sprite)
    end

    it 'should not add to the collection during retrieval' do
      @sprites[:foo]
      @sprites.count.should be(0)
    end
  end

  context '#empty?' do
    it 'should be empty when initialized' do
      @sprites.should be_empty
    end
  end

  context '#count' do
    it 'should respond with the number of sprites in the collection' do
      @sprites.count.should be(0)
      @sprites.add(:foo) {}
      @sprites.count.should be(1)
      @sprites.add(:bar) {}
      @sprites.count.should be(2)
    end
  end

  context "#each" do
    it 'should iterate through the sprites' do
      sprites = Set.new
      test_sprites = Set.new

      4.times do |i|
        sprite = Sprite.new(:"foo#{i}") {}
        sprites << sprite
        @sprites.add(sprite)
      end

      @sprites.each do |sprite|
        test_sprites << sprite
      end

      sprites.should == test_sprites
    end
  end
  
end
