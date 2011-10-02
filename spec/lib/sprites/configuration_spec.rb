require 'spec_helper'
require 'sprites/configuration'

describe Configuration do
  let(:config) do
    Configuration.new
  end

  context "#backend" do
    it 'should be rmagick by default' do
      config.backend.should be(:rmagick)
    end

    it 'should set the backend' do
      config.backend(:mini_magick).backend.should == :mini_magick
    end

    it 'should coerse backend into a symbol' do
      config.backend('mini_magick').backend.should == :mini_magick
    end
  end

  context '#sprites_path' do
    it 'should return the default' do
      config.sprites_path.should == 'images/sprites'
    end

    it 'should accept an override' do
      config.sprites_path('foo').sprites_path.should == 'foo'
    end
  end

  context '#sprite_stylesheets_path' do
    it 'should return the default' do
      config.sprite_stylesheets_path.should == 'stylesheets/sprites'
    end

    it 'should accept an override' do
      config.sprite_stylesheets_path('foo').sprite_stylesheets_path.should == 'foo'
    end
  end

  context '#sprite_stylesheets_path' do
    it 'should return the default' do
      config.sprite_pieces_path.should == 'images/sprite_images'
    end

    it 'should accept an override' do
      config.sprite_pieces_path('foo').sprite_pieces_path.should == 'foo'
    end
  end
end
