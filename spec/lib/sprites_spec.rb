require 'spec_helper'

describe Sprites do

  before do
    @sprites = Sprites.new
  end

  context 'initialize' do
    it 'should create the @sprites Hash' do
      @sprites.instance_variable_get(:@sprites).should be_a(Hash)
    end
  end

  context '#add' do
    context 'with the sprite identified by a symbol' do
      it 'should add a sprite to the collection' do
        @sprites.sprite(:foo)
        @sprites[:foo].should be_a(Sprites::Sprite)
      end
    end

    it 'should add the sprite if passed in a Sprites::Sprite' do
      sprite = Sprites::Sprite.new(:foo, @sprites)
      @sprites.add(sprite)
      @sprites[:foo].should be(sprite)
    end

    it 'should add a sprite defined by only a symbol by using directory conventions and filenames for classes' do
      
      @sprites.configuration.configure(
        :sprites_path => File.join(GEM_ROOT, 'spec/fixtures/project2/public/images/sprites'),
        :sprite_stylesheets_path => File.join(GEM_ROOT, 'spec/fixtures/project2/public/stylesheets/sprites'),
        :sprite_pieces_path => File.join(GEM_ROOT, 'spec/fixtures/project2/public/images/sprite_images')
      )

      @sprites.sprite(:bas)
      @sprites[:bas].sprite_pieces.count.should be(5)
      @sprites[:bas].sprite_pieces.all.map(&:css_selector).should == %w(.bar .bas .bkgd_main_copy .foo .fubar)
    end
  end

  context '#clear' do
    it 'should clear the collection' do
      @sprites.sprite(:foo)
      @sprites.should_not be_empty
      @sprites.clear
      @sprites.should be_empty
    end
  end

  context '#[]' do
    it 'should retrieve the sprite' do
      @sprites[:foo].should be_nil
      @sprites.sprite(:foo)
      @sprites[:foo].should be_a(Sprites::Sprite)
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
      @sprites.sprite(:foo)
      @sprites.count.should be(1)
      @sprites.sprite(:bar)
      @sprites.count.should be(2)
    end
  end

  context "#each" do
    it 'should iterate through the sprites' do
      sprites = Set.new
      test_sprites = Set.new

      4.times do |i|
        sprite = Sprites::Sprite.new(:"foo#{i}", @sprites)
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
