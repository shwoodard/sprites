ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require 'rake'
require 'sprites/test/sprite_generator_tester'
require 'fixtures/rails_project1/config/application'

describe "When creating sprites and stylesheets in a rails app", :rails => true do

  before :all do
    SpritesRailsTestApp::Application.initialize!
  end

  after do
    Rake::Task["sprites"].reenable
  end

  after :all do
    # We only want to do this once, otherwise we get a new config that wasn't
    # initialized by the rails initializers. It's excluded in the after filter
    # in spec_helper for rails specs.
    SpritesRailsTestApp::Application.config.sprites.clear
  end

  def sprites
    Rails.application.config.sprites
  end

  it 'should create the sprites when rake is executed' do
    Rake::Task["sprites"].invoke

    tester = Sprites::SpriteGeneratorTester.new(sprites[:buttons], sprites.configuration)
    tester.should be_accurate

    FileUtils.rm sprites[:buttons].path
    FileUtils.rm sprites[:buttons].stylesheet_path

    tester = Sprites::SpriteGeneratorTester.new(sprites[:bas], sprites.configuration)
    tester.should be_accurate

    FileUtils.rm sprites[:bas].path
    FileUtils.rm sprites[:bas].stylesheet_path
  end

  it 'should autoload sprites' do
    sprites.configuration.sprite_pieces_path.to_s.should == File.join(GEM_ROOT, 'spec/fixtures/rails_project1/app/assets/images/sprite_images')

    sprites[:buttons].should_not be_nil
    sprites[:bas].should_not be_nil

    sprites[:buttons].sprite_pieces.count.should == 87
    sprites[:bas].sprite_pieces.count.should == 5
  end
end
