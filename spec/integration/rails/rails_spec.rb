ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require 'rake'
require 'sprites/test/sprite_generator_tester'
require 'fixtures/rails_project1/config/application'

describe "When creating sprites and stylesheets in a rails app", :rails => true do

  before :all do
    SpritesRailsTestApp::Application.initialize!
  end

  after :all do
    # We only want to do this once, otherwise we get a new config that wasn't
    # initialized by the rails initializers. It's excluded in the after filter
    # in spec_helper for rails specs.
    Sprites.reset!
  end

  it 'should create the sprites when rake is executed' do
    Rake::Task["sprites"].invoke

    tester = Sprites::SpriteGeneratorTester.new(Sprites.application.sprites[:buttons], Sprites.configuration)
    tester.should be_accurate

    FileUtils.rm Sprites::Sprite.sprite_full_path(Sprites.configuration, Sprites.application.sprites[:buttons])
    FileUtils.rm Sprites::Stylesheet.stylesheet_full_path(Sprites.configuration, Sprites.application.sprites[:buttons].stylesheet)

    tester = Sprites::SpriteGeneratorTester.new(Sprites.application.sprites[:bas], Sprites.configuration)
    tester.should be_accurate

    FileUtils.rm Sprites::Sprite.sprite_full_path(Sprites.configuration, Sprites.application.sprites[:bas])
    FileUtils.rm Sprites::Stylesheet.stylesheet_full_path(Sprites.configuration, Sprites.application.sprites[:bas].stylesheet)
  end

  it 'should autoload sprites' do
    Sprites.configure do
      config.sprite_pieces_path.to_s.should == File.join(GEM_ROOT, 'spec/fixtures/rails_project1/app/assets/images/sprite_images')
    end

    Sprites.application.sprites[:buttons].should_not be_nil
    Sprites.application.sprites[:bas].should_not be_nil

    Sprites.application.sprites[:buttons].sprite_pieces.count.should == 87
    Sprites.application.sprites[:bas].sprite_pieces.count.should == 5
  end
end
