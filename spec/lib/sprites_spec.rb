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

  context "#all_files" do
    it "should provide a hash of all output files, associated with all input files" do
      @sprites.configuration.configure(
        :sprites_path => File.join(GEM_ROOT, 'spec/fixtures/project2/public/images/sprites'),
        :sprite_stylesheets_path => File.join(GEM_ROOT, 'spec/fixtures/project2/public/stylesheets/sprites'),
        :sprite_pieces_path => File.join(GEM_ROOT, 'spec/fixtures/project2/public/images/sprite_images')
      )

      @sprites.sprite(:bas)
      @sprites[:bas].sprite_pieces.count.should be(5)
      @sprites[:bas].sprite_pieces.all.map(&:css_selector).should == %w(.bar .bas .bkgd_main_copy .foo .fubar)

      png = File.join(GEM_ROOT, 'spec/fixtures/project2/public/images/sprites/bas.png')
      css = File.join(GEM_ROOT, 'spec/fixtures/project2/public/stylesheets/sprites/bas.css')
      @sprites.all_files.keys.sort.should == [png, css]

      pieces = %w[
        bas/bar.png bas/bas.png bas/bkgd_main_copy.png bas/foo.png bas/fubar.png
      ]
      expected_pngs = pieces.map { |path| File.join(GEM_ROOT, 'spec/fixtures/project2/public/images/sprite_images', path) }

      @sprites.all_files[png].should == expected_pngs
      @sprites.all_files[css].should == expected_pngs


      @sprites.configuration.configure(:definition_file => 'config/sprites.rb')
      @sprites.all_files.keys.sort.should == [png, css, 'config/sprites.rb']

      @sprites.all_files['config/sprites.rb'].should == expected_pngs
    end
  end

  context "#define_file_tasks" do
    let(:rake_app) { Rake::Application.new }
    before { @old_rake_app, Rake.application = Rake.application, rake_app }
    after  { Rake.application = @old_rake_app }

    before do
      @sprites.configuration.configure(
        :sprites_path => File.join(GEM_ROOT, 'spec/fixtures/project2/public/images/sprites'),
        :sprite_stylesheets_path => File.join(GEM_ROOT, 'spec/fixtures/project2/public/stylesheets/sprites'),
        :sprite_pieces_path => File.join(GEM_ROOT, 'spec/fixtures/project2/public/images/sprite_images')
      )

      @sprites.sprite(:bas)
      @sprites[:bas].sprite_pieces.count.should be(5)
      @sprites[:bas].sprite_pieces.all.map(&:css_selector).should == %w(.bar .bas .bkgd_main_copy .foo .fubar)
    end

    it 'should define file tasks for each output file, depending on each input file' do
      @sprites.define_file_tasks

      @sprites.all_files.each do |output, inputs|
        Rake::Task[output].prerequisites.should == inputs
      end
      Rake::Task[:sprites].prerequisites.should == @sprites.all_files.keys

      @sprites.define_file_tasks(:foo)
      Rake::Task[:foo].prerequisites.should == @sprites.all_files.keys
    end
  end

  context "#generate" do
    it "should instance the given generator and call #generate" do
      given_sprites, generated = nil, nil
      mock_generator = Class.new do
        define_method(:initialize) { |sprites| given_sprites = sprites }
        define_method(:generate) { generated = true }
      end
      @sprites.generate(mock_generator)
      given_sprites.should == @sprites
      generated.should be_true
    end
  end
end
