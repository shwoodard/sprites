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

    tester = Sprites::SpriteGeneratorTester.new(Sprites.application.sprites[:buttons], Sprites.configuration)
    tester.should be_accurate

    FileUtils.rm Sprites::Sprite.sprite_full_path(Sprites.configuration, Sprites.application.sprites[:buttons])
    FileUtils.rm Sprites::Stylesheet.stylesheet_full_path(Sprites.configuration, Sprites.application.sprites[:buttons].stylesheet)

    tester = Sprites::SpriteGeneratorTester.new(Sprites.application.sprites[:bas], Sprites.configuration)
    tester.should be_accurate

    FileUtils.rm Sprites::Sprite.sprite_full_path(Sprites.configuration, Sprites.application.sprites[:bas])
    FileUtils.rm Sprites::Stylesheet.stylesheet_full_path(Sprites.configuration, Sprites.application.sprites[:bas].stylesheet)
  end
end
