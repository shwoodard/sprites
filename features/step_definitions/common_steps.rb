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
  `#{Sprites.gem_root}/bin/#{bin}`
  $?.to_i.should be(0)
end

Then(/^I should get valid sprites$/) do
  pending # express the regexp above with the code you wish you had
end
