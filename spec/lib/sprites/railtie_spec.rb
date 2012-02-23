ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require 'rake'
require 'sprites/test/sprite_generator_tester'
require 'fixtures/rails_project1/config/application'

describe Sprites::Railtie do
  before do
    SpritesRailsTestApp::Application.initialize!
  end

  it 'should raise an Sprites::CliApplication::DefinitionFileNotFound if no sprite def file is found' do
    Pathname.any_instance.expects(:exist?).returns(false)
    expect { Rake::Task['sprites'].invoke }.to raise_error(Sprites::CliApplication::DefinitionFileNotFound)
  end
end
