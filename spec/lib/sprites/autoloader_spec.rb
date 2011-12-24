require 'spec_helper'
require 'sprites/autoloader'

describe Autoloader do
  it 'should autoload sprites' do
    Sprites.configure do
      config.sprite_pieces_path = File.join(Sprites.gem_root, 'spec/fixtures/rails_project1/app/assets/images/sprite_images')
    end

    Sprites.application.sprites[:buttons].should be_nil
    Sprites.application.sprites[:bas].should be_nil

    Sprites::Autoloader.new.autoload

    Sprites.application.sprites[:buttons].should_not be_nil
    Sprites.application.sprites[:bas].should_not be_nil

    Sprites.application.sprites[:buttons].sprite_pieces.count.should == 87
    Sprites.application.sprites[:bas].sprite_pieces.count.should == 5
  end
end
