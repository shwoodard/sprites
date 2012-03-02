ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require 'rake'
require 'sprites/test/sprite_generator_tester'
require 'fixtures/rails_project1/config/application'

describe "When creating sprites and stylesheets in a rails app", :rails => true do

  let(:application_sprites) { SpritesRailsTestApp::Application.config.sprites_for_sprites_rails_test_app_application }

  let(:engine_sprites) { FakeEngine::Engine.config.sprites_for_fake_engine_engine }

  before :all do
    SpritesRailsTestApp::Application.initialize!
  end

  after :all do
    # We only want to do this once, otherwise we get a new config that wasn't
    # initialized by the rails initializers. It's excluded in the after filter
    # in spec_helper for rails specs.
    each_engine {|sprites| sprites.clear }
  end

  def each_engine
    [engine_sprites, application_sprites].each do |sprites|
      yield sprites
    end
  end

  it 'should create the sprites when rake is executed' do
    ENV['ENGINES'] = "true"
    Rake::Task["sprites"].invoke

    each_engine do |sprites|
      tester = Sprites::SpriteGeneratorTester.new(sprites[:buttons])
      tester.should be_accurate

      FileUtils.rm sprites[:buttons].path
      FileUtils.rm sprites[:buttons].stylesheet_path

      tester = Sprites::SpriteGeneratorTester.new(sprites[:bas])
      tester.should be_accurate

      FileUtils.rm sprites[:bas].path
      FileUtils.rm sprites[:bas].stylesheet_path
    end
  end

  it 'should autoload sprites' do
    each_engine do |sprites|
      sprites[:buttons].should_not be_nil
      sprites[:bas].should_not be_nil

      sprites[:buttons].sprite_pieces.count.should == 87
      sprites[:bas].sprite_pieces.count.should == 5
    end
  end
end
