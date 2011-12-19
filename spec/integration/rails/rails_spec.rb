ENV['RAILS_ENV'] ||= 'test'
require 'rake'
require 'spec_helper'
require 'rails/all'
require 'fixtures/rails_project1/config/application'
require 'rspec-rails'
require 'sprites/test/sprite_generator_tester'

describe "When creating sprites and stylesheets in a rails app" do
  it 'should create the sprites when rake is executed' do
    Rake::Task["sprites"].invoke

    tester = SpriteGeneratorTester.new(Sprites.application.sprites[:buttons], Sprites.configuration)
    tester.should be_accurate

    FileUtils.rm Sprite.sprite_full_path(Sprites.configuration, Sprites.application.sprites[:buttons])
    FileUtils.rm Stylesheet.stylesheet_full_path(Sprites.configuration, Sprites.application.sprites[:buttons].stylesheet)

    tester = SpriteGeneratorTester.new(Sprites.application.sprites[:bas], Sprites.configuration)
    tester.should be_accurate

    FileUtils.rm Sprite.sprite_full_path(Sprites.configuration, Sprites.application.sprites[:bas])
    FileUtils.rm Stylesheet.stylesheet_full_path(Sprites.configuration, Sprites.application.sprites[:bas].stylesheet)
  end
end
