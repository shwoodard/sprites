require 'sprites/test/sprite_generator_tester'
require 'sprites/cli/command_line_option_parser'

Given(/^a project folder$/) do
  Dir.chdir 'spec/fixtures/project1'
end

Given(/^it contains a sprites dsl definition file$/) do
  has_def = File.exists?('config/sprites.rb') || File.exists?('sprites.rb')
  has_def.should be_true
end

Given(/^it contains sprite images$/) do
  Dir['public/images/sprite_images/**/*.png'].should_not be_empty
end

When(/^I run the executable "([^"]*)"$/) do |bin|
  `#{GEM_ROOT}/bin/#{bin}`
  $?.to_i.should be(0)
end

Then(/^I should get valid sprites$/) do
  options = Sprites::CommandLineOptionParser.new($*)
  options.parse

  sprite_definition_file_path = options.definition_file_path
  configuration = Sprites::Configuration.new_for_command_line_options(options.options)

  require sprite_definition_file_path

  tester = Sprites::SpriteGeneratorTester.new(Sprites.application.sprites[:buttons], configuration)
  tester.should be_accurate

  FileUtils.rm Sprites::Sprite.sprite_full_path(configuration, Sprites.application.sprites[:buttons])
  FileUtils.rm Sprites::Stylesheet.stylesheet_full_path(configuration, Sprites.application.sprites[:buttons].stylesheet)
end
