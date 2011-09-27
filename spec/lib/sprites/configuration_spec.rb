require 'spec_helper'
require 'sprites/configuration'

describe Configuration do
  let(:config) do
    Configuration.new
  end

  context "#backend" do
    it 'should receive the default' do
      config.backend.should be(:rmagick)
    end

    it 'should set the backend' do
      config.backend(:mini_magick).backend.should == :mini_magick
    end

    it 'should coerse backend into a symbol' do
      config.backend('mini_magick').backend.should == :mini_magick
    end
  end

  context '#images_path' do
    it 'should receive the default' do
      config.images_path.should == 'images'
    end

    it 'should accept an override' do
      config.images_path('foo').images_path.should == 'foo'
    end
  end

  context '#stylesheets_path' do
    it 'should receive the default' do
      config.stylesheets_path.should == 'stylesheets'
    end

    it 'should accept an override' do
      config.stylesheets_path('foo').stylesheets_path.should == 'foo'
    end
  end

  context '#sprites_path' do
    it 'should return the default' do
      config.sprites_path.should == 'images/sprites'
    end

    it 'should return nil if not set and called _without_default' do
      config.sprites_path_without_default.should be(nil)
    end

    it 'should accept an override' do
      config.sprites_path('foo').sprites_path.should == 'foo'
    end
  end

  context '#sprite_stylesheets_path' do
    it 'should return the default' do
      config.sprite_stylesheets_path.should == 'stylesheets/sprites'
    end

    it 'should return nil if not set and called _without_default' do
      config.sprites_path_without_default.should be(nil)
    end

    it 'should accept an override' do
      config.sprite_stylesheets_path('foo').sprite_stylesheets_path.should == 'foo'
    end
  end

  context '#sprite_stylesheets_path' do
    it 'should return the default' do
      config.sprite_pieces_path.should == 'images/sprite_images'
    end

    it 'should return nil if not set and called _without_default' do
      config.sprite_pieces_path_without_default.should be(nil)
    end

    it 'should accept an override' do
      config.sprite_pieces_path('foo').sprite_pieces_path.should == 'foo'
    end
  end
end
